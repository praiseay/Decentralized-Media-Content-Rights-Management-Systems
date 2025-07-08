;; Licensing Coordination Contract
;; Coordinates content licensing agreements and terms

(define-constant CONTRACT_OWNER tx-sender)
(define-constant ERR_UNAUTHORIZED (err u200))
(define-constant ERR_INVALID_LICENSE (err u201))
(define-constant ERR_EXPIRED_LICENSE (err u202))
(define-constant ERR_INSUFFICIENT_PAYMENT (err u203))

;; License types
(define-constant LICENSE_EXCLUSIVE u1)
(define-constant LICENSE_NON_EXCLUSIVE u2)
(define-constant LICENSE_ROYALTY_FREE u3)

;; Data structures
(define-map licenses
  { license-id: (string-ascii 64) }
  {
    content-id: (string-ascii 64),
    licensor: principal,
    licensee: principal,
    license-type: uint,
    price: uint,
    duration: uint,
    start-block: uint,
    end-block: uint,
    active: bool,
    usage-limit: uint,
    current-usage: uint
  }
)

(define-map license-terms
  { content-id: (string-ascii 64), license-type: uint }
  {
    base-price: uint,
    max-duration: uint,
    usage-multiplier: uint,
    exclusive-premium: uint
  }
)

(define-data-var license-counter uint u0)

;; Public functions
(define-public (set-license-terms
  (content-id (string-ascii 64))
  (license-type uint)
  (base-price uint)
  (max-duration uint)
  (usage-multiplier uint)
  (exclusive-premium uint)
)
  (begin
    ;; Verify caller is content owner/manager (simplified for demo)
    (map-set license-terms
      { content-id: content-id, license-type: license-type }
      {
        base-price: base-price,
        max-duration: max-duration,
        usage-multiplier: usage-multiplier,
        exclusive-premium: exclusive-premium
      }
    )
    (ok true)
  )
)

(define-public (create-license
  (content-id (string-ascii 64))
  (licensee principal)
  (license-type uint)
  (duration uint)
  (usage-limit uint)
)
  (let (
    (license-id (int-to-ascii (var-get license-counter)))
    (terms (unwrap! (map-get? license-terms { content-id: content-id, license-type: license-type }) ERR_INVALID_LICENSE))
    (calculated-price (calculate-license-price terms duration usage-limit license-type))
  )
    (asserts! (<= duration (get max-duration terms)) ERR_INVALID_LICENSE)

    (map-set licenses
      { license-id: license-id }
      {
        content-id: content-id,
        licensor: tx-sender,
        licensee: licensee,
        license-type: license-type,
        price: calculated-price,
        duration: duration,
        start-block: block-height,
        end-block: (+ block-height duration),
        active: true,
        usage-limit: usage-limit,
        current-usage: u0
      }
    )
    (var-set license-counter (+ (var-get license-counter) u1))
    (ok license-id)
  )
)

(define-public (activate-license (license-id (string-ascii 64)))
  (let ((license-data (unwrap! (map-get? licenses { license-id: license-id }) ERR_INVALID_LICENSE)))
    (asserts! (is-eq tx-sender (get licensee license-data)) ERR_UNAUTHORIZED)
    (asserts! (< block-height (get end-block license-data)) ERR_EXPIRED_LICENSE)

    ;; Payment logic would go here (simplified for demo)
    (map-set licenses
      { license-id: license-id }
      (merge license-data { active: true })
    )
    (ok true)
  )
)

;; Private functions
(define-private (calculate-license-price (terms (tuple (base-price uint) (max-duration uint) (usage-multiplier uint) (exclusive-premium uint))) (duration uint) (usage-limit uint) (license-type uint))
  (let (
    (base (* (get base-price terms) duration))
    (usage-cost (* usage-limit (get usage-multiplier terms)))
    (type-premium (if (is-eq license-type LICENSE_EXCLUSIVE) (get exclusive-premium terms) u0))
  )
    (+ base usage-cost type-premium)
  )
)

;; Read-only functions
(define-read-only (get-license (license-id (string-ascii 64)))
  (map-get? licenses { license-id: license-id })
)

(define-read-only (is-license-valid (license-id (string-ascii 64)))
  (match (map-get? licenses { license-id: license-id })
    license-data (and
      (get active license-data)
      (< block-height (get end-block license-data))
      (< (get current-usage license-data) (get usage-limit license-data))
    )
    false
  )
)

(define-read-only (get-license-terms (content-id (string-ascii 64)) (license-type uint))
  (map-get? license-terms { content-id: content-id, license-type: license-type })
)
