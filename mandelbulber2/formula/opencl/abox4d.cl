/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2017 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * Formula based on Mandelbox (ABox). Extended to 4 dimensions
 * This formula contains aux.color and aux.actualScale
 */

/* ### This file has been autogenerated. Remove this line, to prevent override. ### */

REAL4 Abox4dIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	aux->actualScale = mad(
		(fabs(aux->actualScale) - 1.0f), fractal->mandelboxVary4D.scaleVary, fractal->mandelbox.scale);

	// parabolic = paraOffset + iter *slope + (iter *iter *scale)
	REAL paraAddP0 = 0.0f;
	if (fractal->Cpara.enabledParabFalse)
	{
		REAL parabScale = 0.0f;
		if (fractal->Cpara.parabScale != 0.0f)
			parabScale = aux->i * aux->i * 0.001f * fractal->Cpara.parabScale;
		paraAddP0 = fractal->Cpara.parabOffset0 + (aux->i * fractal->Cpara.parabSlope) + (parabScale);
		z.w += paraAddP0;
	}

	REAL4 oldZ = z;
	z.x = fabs(z.x + fractal->transformCommon.offset1111.x)
				- fabs(z.x - fractal->transformCommon.offset1111.x) - z.x;
	z.y = fabs(z.y + fractal->transformCommon.offset1111.y)
				- fabs(z.y - fractal->transformCommon.offset1111.y) - z.y;
	z.z = fabs(z.z + fractal->transformCommon.offset1111.z)
				- fabs(z.z - fractal->transformCommon.offset1111.z) - z.z;
	z.w = fabs(z.w + fractal->transformCommon.offset1111.w)
				- fabs(z.w - fractal->transformCommon.offset1111.w) - z.w;
	if (z.x != oldZ.x) aux->color += fractal->mandelbox.color.factor4D.x;
	if (z.y != oldZ.y) aux->color += fractal->mandelbox.color.factor4D.y;
	if (z.z != oldZ.z) aux->color += fractal->mandelbox.color.factor4D.z;
	if (z.w != oldZ.w) aux->color += fractal->mandelbox.color.factor4D.w;

	REAL rr = dot(z, z);
	if (fractal->mandelboxVary4D.rPower != 1.0f)
		rr = native_powr(rr, fractal->mandelboxVary4D.rPower);

	z += fractal->transformCommon.offset0000;
	if (rr < fractal->transformCommon.minR2p25)
	{
		z *= fractal->transformCommon.maxMinR2factor;
		aux->DE *= fractal->transformCommon.maxMinR2factor;
		aux->color += fractal->mandelbox.color.factorSp1;
	}
	else if (rr < fractal->transformCommon.maxR2d1)
	{
		z *= native_divide(fractal->transformCommon.maxR2d1, rr);
		aux->DE *= native_divide(fractal->transformCommon.maxR2d1, rr);
		aux->color += fractal->mandelbox.color.factorSp2;
	}
	z -= fractal->transformCommon.offset0000;

	z *= aux->actualScale;
	aux->DE = mad(aux->DE, fabs(aux->actualScale), 1.0f);

	// 6 plane rotation
	if (fractal->transformCommon.functionEnabledRFalse
			&& aux->i >= fractal->transformCommon.startIterationsR
			&& aux->i < fractal->transformCommon.stopIterationsR)
	{
		REAL4 tp;
		if (fractal->transformCommon.rotation44a.x != 0)
		{
			tp = z;
			REAL alpha = fractal->transformCommon.rotation44a.x * M_PI_180;
			z.x = mad(tp.x, native_cos(alpha), tp.y * native_sin(alpha));
			z.y = tp.x * -native_sin(alpha) + tp.y * native_cos(alpha);
		}
		if (fractal->transformCommon.rotation44a.y != 0)
		{
			tp = z;
			REAL beta = fractal->transformCommon.rotation44a.y * M_PI_180;
			z.y = mad(tp.y, native_cos(beta), tp.z * native_sin(beta));
			z.z = tp.y * -native_sin(beta) + tp.z * native_cos(beta);
		}
		if (fractal->transformCommon.rotation44a.z != 0)
		{
			tp = z;
			REAL gamma = fractal->transformCommon.rotation44a.z * M_PI_180;
			z.x = mad(tp.x, native_cos(gamma), tp.z * native_sin(gamma));
			z.z = tp.x * -native_sin(gamma) + tp.z * native_cos(gamma);
		}
		if (fractal->transformCommon.rotation44b.x != 0)
		{
			tp = z;
			REAL delta = fractal->transformCommon.rotation44b.x * M_PI_180;
			z.x = mad(tp.x, native_cos(delta), tp.w * native_sin(delta));
			z.w = tp.x * -native_sin(delta) + tp.w * native_cos(delta);
		}
		if (fractal->transformCommon.rotation44b.y != 0)
		{
			tp = z;
			REAL epsilon = fractal->transformCommon.rotation44b.y * M_PI_180;
			z.y = mad(tp.y, native_cos(epsilon), tp.w * native_sin(epsilon));
			z.w = tp.y * -native_sin(epsilon) + tp.w * native_cos(epsilon);
		}
		if (fractal->transformCommon.rotation44b.z != 0)
		{
			tp = z;
			REAL zeta = fractal->transformCommon.rotation44b.z * M_PI_180;
			z.z = mad(tp.z, native_cos(zeta), tp.w * native_sin(zeta));
			z.w = tp.z * -native_sin(zeta) + tp.w * native_cos(zeta);
		}
	}
	z += fractal->transformCommon.additionConstant0000;

	aux->foldFactor = fractal->foldColor.compFold;
	aux->minRFactor = fractal->foldColor.compMinR;
	REAL scaleColor = fractal->foldColor.colorMin + fabs(aux->actualScale);
	// scaleColor += fabs(fractal->mandelbox.scale);
	aux->scaleFactor = scaleColor * fractal->foldColor.compScale;
	return z;
}