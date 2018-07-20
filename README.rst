===========
 Recompile
===========

This is a small helper to recompile given Common Lisp system, very
useful if you wish to produce high quality software by demolution of all
compiler's warnings.

By default all warnings are considered as errors.

If system uses ``:package-inferred-system`` class, then all known subsystems
are also will be recompiled.

How to call:

.. code:: lisp

          (ql:quickload :recompile)
          ;; This will ensure, your system is known to asdf
          ;; but warnings will be suppresed or not shown
          ;; because some lisp files are not newer than their
          ;; cached fasl counterparts
          (ql:quickload :your-system)

          ;; And this will fully recompile the system
          ;; ignoring already existing fasl files
          (recompile:recompile :your-system)


Tested under ClozureCL and SBCL. For some reason, SBCL's compiler notes
can't be considered as errors and debugger will not be called on
them. Pay attention to the output, when using SBCL.

Known issues
============

When recompiling package inferred system, some subsystems can be
recompiled more than once, because they may be used as dependencies of
other systems.
