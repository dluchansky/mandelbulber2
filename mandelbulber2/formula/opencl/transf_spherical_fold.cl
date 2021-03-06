/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2018 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * spherical fold MBox
 * This formula contains aux.color

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the file "fractal_transf_spherical_fold.cpp" in the folder formula/definition
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 TransfSphericalFoldIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	REAL r2 = dot(z, z);
	z += fractal->mandelbox.offset;
	z *= fractal->transformCommon.scale;

	// if (r2 < 1e-21f) r2 = 1e-21f;
	if (r2 < fractal->mandelbox.mR2)
	{
		z *= fractal->mandelbox.mboxFactor1;
		aux->DE *= fractal->mandelbox.mboxFactor1;
		if (fractal->foldColor.auxColorEnabledFalse)
		{
			aux->color += fractal->mandelbox.color.factorSp1;
		}
	}
	else if (r2 < fractal->mandelbox.fR2)
	{
		REAL tglad_factor2 = native_divide(fractal->mandelbox.fR2, r2);
		z *= tglad_factor2;
		aux->DE *= tglad_factor2;
		if (fractal->foldColor.auxColorEnabledFalse)
		{
			aux->color += fractal->mandelbox.color.factorSp2;
		}
	}
	z -= fractal->mandelbox.offset;
	// Analytic DE tweak
	if (!fractal->analyticDE.enabledFalse)
		aux->DE = mad(aux->DE, fabs(fractal->transformCommon.scale), 1.0f);
	else
		aux->DE = mad(aux->DE * fabs(fractal->transformCommon.scale), fractal->analyticDE.scale1,
			fractal->analyticDE.offset0);
	return z;
}