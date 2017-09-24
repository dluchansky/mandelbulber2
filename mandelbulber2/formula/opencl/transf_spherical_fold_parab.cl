/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2017 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * spherical fold Parab, coded by mclarekin
 * @reference
 * http://www.fractalforums.com/amazing-box-amazing-surf-and-variations/smooth-spherical-fold/msg101051/#new
 * This formula contains aux.color and aux.actualScaleA
 */

/* ### This file has been autogenerated. Remove this line, to prevent override. ### */

REAL4 TransfSphericalFoldParabIteration(
	REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	REAL m = 1.0f;
	REAL rr;
	// spherical fold
	if (fractal->transformCommon.functionEnabledSFalse
			&& aux->i >= fractal->transformCommon.startIterationsS
			&& aux->i < fractal->transformCommon.stopIterationsS)
	{
		rr = dot(z, z);
		REAL tempM = rr + fractal->transformCommon.offsetB0;
		m = fractal->transformCommon.maxMinR2factor;
		// if (r2 < 1e-21f) r2 = 1e-21f;
		if (rr < fractal->transformCommon.minR2p25)
		{
			if (fractal->transformCommon.functionEnabledAyFalse && m > tempM) m = tempM + (tempM - m);
			z *= m;
			aux->DE = mad(aux->DE, m, 1.0f);
			aux->r_dz *= m;
			if (fractal->foldColor.auxColorEnabledFalse)
			{
				aux->color += fractal->mandelbox.color.factorSp1;
			}
		}
		else if (rr < fractal->transformCommon.maxR2d1)
		{

			REAL m = native_divide(fractal->transformCommon.maxR2d1, rr);
			if (fractal->transformCommon.functionEnabledAyFalse && m > tempM) m = tempM + (tempM - m);
			z *= m;
			aux->DE = mad(aux->DE, m, 1.0f);
			aux->r_dz *= m;
			if (fractal->foldColor.auxColorEnabledFalse)
			{
				aux->color += fractal->mandelbox.color.factorSp2;
			}
		}
	}
	if (aux->i >= fractal->transformCommon.startIterations
			&& aux->i < fractal->transformCommon.stopIterations)
	{
		rr = dot(z, z);
		z += fractal->mandelbox.offset;
		z *= fractal->transformCommon.scale;
		aux->DE = mad(aux->DE, fabs(fractal->transformCommon.scale), 1.0f);
		REAL maxScale = fractal->transformCommon.scale4;
		REAL midPoint = (maxScale - 1.0f) * 0.5f;
		rr += fractal->transformCommon.offset0;
		REAL maxR2 = fractal->transformCommon.scale1;
		REAL halfMax = maxR2 * 0.5f;
		REAL factor = native_divide(midPoint, (halfMax * halfMax));
		// REAL m = 1.0f;

		REAL tempM = rr + fractal->transformCommon.offsetA0;
		if (rr < halfMax)
		{
			m = mad(-factor, (rr * rr), maxScale);
			m = mad(factor, (maxR2 - rr) * (maxR2 - rr), 1.0f);
			if (fractal->transformCommon.functionEnabledAxFalse && m > tempM) m = tempM + (tempM - m);
			z *= m;
			aux->DE = mad(aux->DE, m, 1.0f);
			aux->r_dz *= m;
			if (fractal->foldColor.auxColorEnabledFalse)
			{
				aux->color += fractal->mandelbox.color.factorSp1;
			}
		}
		else if (rr < maxR2)
		{
			m = mad(factor, (maxR2 - rr) * (maxR2 - rr), 1.0f);
			if (fractal->transformCommon.functionEnabledAxFalse && m > tempM) m = tempM + (tempM - m);
			z *= m;
			aux->DE = mad(aux->DE, m, 1.0f);
			aux->r_dz *= m;
			if (fractal->foldColor.auxColorEnabledFalse)
			{
				aux->color += fractal->mandelbox.color.factorSp2;
			}
		}
	}
	z -= fractal->mandelbox.offset;

	// post scale
	if (aux->i >= fractal->transformCommon.startIterationsA
			&& aux->i < fractal->transformCommon.stopIterationsA)
	{
		REAL useScale = aux->actualScaleA + fractal->transformCommon.scaleA1;
		z *= useScale;
		aux->DE = mad(aux->DE, fabs(useScale), 1.0f);
		aux->r_dz *= fabs(useScale);
		// update actualScale for next iteration

		REAL vary = fractal->transformCommon.scaleVary0
								* (fabs(aux->actualScaleA) - fractal->transformCommon.scaleB1);
		if (fractal->transformCommon.functionEnabledMFalse)
			aux->actualScaleA = -vary;
		else
			aux->actualScaleA = aux->actualScaleA - vary;
	}
	return z;
}