/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2019 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * Testing
 *
 * https://www.shadertoy.com/view/3ddSDs
 * Based upon: https://www.shadertoy.com/view/XdlSD4

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the function "TestingIteration" in the file fractal_formulas.cpp
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 TestingIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{

	z = fabs(z + fractal->transformCommon.additionConstant111)
			- fabs(z - fractal->transformCommon.additionConstant111) - z;

	REAL rr = dot(z, z);
	if (rr < fractal->transformCommon.minR2p25)
	{
		z *= fractal->transformCommon.maxMinR2factor;
		aux->DE *= fractal->transformCommon.maxMinR2factor;
	}
	else if (rr < fractal->transformCommon.maxR2d1)
	{
		z *= native_divide(fractal->transformCommon.maxR2d1, rr);
		aux->DE *= native_divide(fractal->transformCommon.maxR2d1, rr);
	}
	z *= fractal->transformCommon.scale2;
	aux->DE = mad(aux->DE, fabs(fractal->transformCommon.scale2), 1.0f);


	z += fractal->transformCommon.offset000;
	z += aux->c * fractal->transformCommon.constantMultiplier111;
	// rotation
	if (fractal->transformCommon.functionEnabledRFalse)
	{
		z = Matrix33MulFloat4(fractal->transformCommon.rotationMatrix, z);
	}

	REAL4 zc = z;

		// cylinder
	REAL cylinder;
	REAL cylR = native_sqrt(zc.x * zc.x + zc.y * zc.y) - fractal->transformCommon.radius1;
	REAL cylH = fabs(zc.z) - fractal->transformCommon.offsetA1;
	cylR = max(cylR, 0.0);
	cylH = max(cylH, 0.0);
	REAL cylD = native_sqrt(cylR * cylR + cylH * cylH);
	cylinder = min(max(cylR, cylH), 0.0) + cylD;

		// box
	REAL4 boxSize = fractal->transformCommon.offset111;
	zc = fabs(zc) - boxSize;
	zc.x = max(zc.x, 0.0);
	zc.y = max(zc.y, 0.0);
	zc.z = max(zc.z, 0.0);
	REAL box = length(zc);
	zc = z;

	// ellipsoid
	REAL4 rads4 = fractal->transformCommon.offsetA111;
	REAL3 rads3 = (REAL3){rads4.x, rads4.y, rads4.z};
	REAL3 rV = (REAL3){zc.x, zc.y, zc.z};
	rV /= rads3;
	REAL3 rrV = rV;
	rrV /= rads3;
	REAL rd = length(rv);
	REAL rrd = length(rrV);
	REAL ellipsoid = rd * (rd - 1.0) / rrd;

		// sphere
	REAL sphere = length(z) - fractal->transformCommon.offset3;

		// torus
	REAL torus = native_sqrt(mad(zc.x, zc.x, zc.z * zc.z)) - fractal->transformCommon.offset4;
	torus = native_sqrt(mad(torus, torus, zc.y * zc.y)) - fractal->transformCommon.offset1;

	if (fractal->transformCommon.functionEnabledxFalse) torus = cylinder;
	if (fractal->transformCommon.functionEnabledyFalse) sphere = box;
	if (fractal->transformCommon.functionEnabledzFalse) sphere = ellipsoid;

	int count = fractal->transformCommon.int3;
	int tempC = fractal->transformCommon.int3X;
	REAL r;
	if (!fractal->transformCommon.functionEnabledSwFalse)
		{ r = (aux->i < count) ? torus : sphere;}
	else
		{ r = (aux->i < count) ? sphere : torus;}

	REAL dd = native_divide(r, aux->DE);
	if (aux->i < tempC || dd < aux->colorHybrid)
	{
		aux->colorHybrid = dd;
	}

	aux->dist = aux->colorHybrid;
	return z;
}
