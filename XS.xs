#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include "const-c.inc"

MODULE = TOBYINK::Acme::Acme::Acme::XS		PACKAGE = TOBYINK::Acme::Acme::Acme::XS

INCLUDE: const-xs.inc

int
_acme_acme()
	PROTOTYPE: DISABLE
	CODE:
		RETVAL = 42;
	OUTPUT:
		RETVAL
