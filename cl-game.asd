(defsystem "cl-game"
  :description "A Common Lisp test game"
  :author "Alexia Loddo"
  :license "MIT"
  :version "0.1.0"
  :depends-on (:cl-raylib :3d-vectors :cl-fast-ecs)
  :serial t
  :components ((:file "src/main")))
