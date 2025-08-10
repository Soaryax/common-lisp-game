(require :cl-raylib)

(defpackage :game-main
  (:use :cl :raylib :3d-vectors :cl-fast-ecs))

(in-package :game-main)

(defvar *camera* (make-camera3d :position (vec3 0 10 10) :target (vec3) :fovy 45 :up (vec3 0 1 0) :projection  :camera-perspective))
(defvar *camera-distance* 5)

(ecs:define-component transform
  (position (vec3) :type vec3)
  (rotation (vec3) :type vec3)
  (scale (vec3 1 1 1) :type vec3))

(ecs:define-component character-controller
  (speed 10.0 :type single-float))

(ecs:define-component cube-shape
  (color :skyblue))

(ecs:define-system cube-draw-system
  (:components-ro (transform cube-shape))
  (with-mode-3d (*camera*)
    (draw-cube-v transform-position transform-scale cube-shape-color)))

(ecs:define-system character-control-system
  (:components-ro (character-controller)
   :components-rw (transform)
   :arguments ((:dt single-float)))
  (let ((speed (* dt character-controller-speed)))
    (if (is-key-down :key-s)
        (incf (vz transform-position) speed))
    (if (is-key-down :key-w)
        (decf (vz transform-position) speed))
    (if (is-key-down :key-d)
        (incf (vx transform-position) speed))
    (if (is-key-down :key-a)
        (decf (vx transform-position) speed))))

(defun main ()
  (let ((screen-width 800)
        (screen-height 450))
    (ecs:make-storage)
    (ecs:make-object `((:transform) (:cube-shape) (:character-controller)))
    (ecs:make-object `((:transform :position ,(vec3 0 -1 0) :scale ,(vec3 20 0.5 20)) (:cube-shape :color :green)))
    (with-window (screen-width screen-height "CL Game")
      (set-target-fps 60)
      (loop until (window-should-close)
        do
          (with-drawing
            (clear-background :raywhite)
            (ecs:run-systems :dt (get-frame-time)))
        ))))

(main)
