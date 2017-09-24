/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2017 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * Amazing Surface Multi
 * Based on Amazing Surf Mod 1 from Mandelbulber3D, a formula proposed by Kali,
 * with features added by Darkbeam
 */

/* ### This file has been autogenerated. Remove this line, to prevent override. ### */

REAL4 AmazingSurfMultiIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	REAL4 c = aux->const_c;
	REAL4 oldZ = z;
	bool functionEnabledN[5] = {fractal->transformCommon.functionEnabledAx,
		fractal->transformCommon.functionEnabledAyFalse,
		fractal->transformCommon.functionEnabledAzFalse,
		fractal->transformCommon.functionEnabledBxFalse,
		fractal->transformCommon.functionEnabledByFalse};
	int startIterationN[5] = {fractal->transformCommon.startIterationsA,
		fractal->transformCommon.startIterationsB, fractal->transformCommon.startIterationsC,
		fractal->transformCommon.startIterationsD, fractal->transformCommon.startIterationsE};
	int stopIterationN[5] = {fractal->transformCommon.stopIterationsA,
		fractal->transformCommon.stopIterationsB, fractal->transformCommon.stopIterationsC,
		fractal->transformCommon.stopIterationsD, fractal->transformCommon.stopIterationsE};
	enumMulti_orderOfFoldsCl foldN[5] = {fractal->surfFolds.orderOfFolds1,
		fractal->surfFolds.orderOfFolds2, fractal->surfFolds.orderOfFolds3,
		fractal->surfFolds.orderOfFolds4, fractal->surfFolds.orderOfFolds5};

	for (int f = 0; f < 5; f++)
	{
		if (functionEnabledN[f] && aux->i >= startIterationN[f] && aux->i < stopIterationN[f])
		{
			switch (foldN[f])
			{
				case multi_orderOfFoldsCl_type1: // tglad fold
				default:
					z.x = fabs(z.x + fractal->transformCommon.additionConstant111.x)
								- fabs(z.x - fractal->transformCommon.additionConstant111.x) - z.x;
					z.y = fabs(z.y + fractal->transformCommon.additionConstant111.y)
								- fabs(z.y - fractal->transformCommon.additionConstant111.y) - z.y;
					if (z.x != oldZ.x) aux->color += fractal->mandelbox.color.factor.x;
					if (z.y != oldZ.y) aux->color += fractal->mandelbox.color.factor.y;
					break;
				case multi_orderOfFoldsCl_type2: // z = fold - fabs( fabs(z) - fold)
					z.x = fractal->transformCommon.additionConstant111.x
								- fabs(fabs(z.x) - fractal->transformCommon.additionConstant111.x);
					z.y = fractal->transformCommon.additionConstant111.y
								- fabs(fabs(z.y) - fractal->transformCommon.additionConstant111.y);
					if (z.x != oldZ.x) aux->color += fractal->mandelbox.color.factor.x;
					if (z.y != oldZ.y) aux->color += fractal->mandelbox.color.factor.y;
					break;
				case multi_orderOfFoldsCl_type3:
					z.x = fabs(z.x + fractal->transformCommon.additionConstant111.x);
					z.y = fabs(z.y + fractal->transformCommon.additionConstant111.y);
					break;
				case multi_orderOfFoldsCl_type4:
					// if z > limit) z =  Value -z,   else if z < limit) z = - Value - z,
					if (fabs(z.x) > fractal->transformCommon.additionConstant111.x)
					{
						z.x = mad(sign(z.x), fractal->mandelbox.foldingValue, -z.x);
						aux->color += fractal->mandelbox.color.factor.x;
					}
					if (fabs(z.y) > fractal->transformCommon.additionConstant111.y)
					{
						z.y = mad(sign(z.y), fractal->mandelbox.foldingValue, -z.y);
						aux->color += fractal->mandelbox.color.factor.y;
					}
					break;
				case multi_orderOfFoldsCl_type5:
					// z = fold2 - fabs( fabs(z + fold) - fold2) - fabs(fold)
					z.x = fractal->transformCommon.offset2
								- fabs(fabs(z.x + fractal->transformCommon.additionConstant111.x)
											 - fractal->transformCommon.offset2)
								- fractal->transformCommon.additionConstant111.x;
					z.y = fractal->transformCommon.offset2
								- fabs(fabs(z.y + fractal->transformCommon.additionConstant111.y)
											 - fractal->transformCommon.offset2)
								- fractal->transformCommon.additionConstant111.y;
					if (z.x != oldZ.x) aux->color += fractal->mandelbox.color.factor.x;
					if (z.y != oldZ.y) aux->color += fractal->mandelbox.color.factor.y;
					break;
			}
		}
	}

	if (fractal->transformCommon.functionEnabledAxFalse)
	{ // enable z scale
		REAL zLimit = fractal->transformCommon.foldingLimit * fractal->transformCommon.scale0;
		REAL zValue = fractal->transformCommon.foldingValue * fractal->transformCommon.scale0;
		if (fabs(z.z) > zLimit)
		{
			z.z = mad(sign(z.z), zValue, -z.z);
		}
	}
	z += fractal->transformCommon.additionConstant000;

	// standard functions
	if (fractal->transformCommon.functionEnabledAy)
	{
		REAL r2;
		r2 = dot(z, z);
		if (fractal->transformCommon.functionEnabledFalse)		// force cylinder fold
			r2 -= z.z * z.z * fractal->transformCommon.scaleB1; // fold weight  ;

		if (fractal->transformCommon.functionEnabledAz
				&& aux->i >= fractal->transformCommon.startIterationsT
				&& aux->i < fractal->transformCommon.stopIterationsT)
		{
			// Abox Spherical fold
			z += fractal->mandelbox.offset;
			REAL sqrtMinR = fractal->transformCommon.sqtR;

			if (r2 < sqrtMinR)
			{
				z *= fractal->transformCommon.mboxFactor1;
				aux->DE *= fractal->transformCommon.mboxFactor1;
				aux->color += fractal->mandelbox.color.factorSp1;
			}
			else if (r2 < 1.0f)
			{
				z *= native_recip(r2);
				aux->DE *= native_recip(r2);
				aux->color += fractal->mandelbox.color.factorSp2;
			}
			z -= fractal->mandelbox.offset;
		}

		// Mandelbox Spherical fold
		if (fractal->transformCommon.functionEnabledzFalse
				&& aux->i >= fractal->transformCommon.startIterationsM
				&& aux->i < fractal->transformCommon.stopIterationsM)
		{
			// r2 = dot(z, z);
			z += fractal->mandelbox.offset;
			if (r2 < fractal->mandelbox.mR2) // mR2 = minR^2
			{
				z *= fractal->mandelbox.mboxFactor1; // fR2/mR2
				aux->DE *= fractal->mandelbox.mboxFactor1;
				aux->color += fractal->mandelbox.color.factorSp1;
			}
			else if (r2 < fractal->mandelbox.fR2)
			{
				REAL tglad_factor2 = native_divide(fractal->mandelbox.fR2, r2);
				z *= tglad_factor2;
				aux->DE *= tglad_factor2;
				aux->color += fractal->mandelbox.color.factorSp2;
			}
			z -= fractal->mandelbox.offset;
		}

		if (aux->i >= fractal->transformCommon.startIterationsS
				&& aux->i < fractal->transformCommon.stopIterationsS)
		{ // scale
			z *= mad(fractal->mandelbox.scale, fractal->transformCommon.scale1,
				1.0f * (1.0f - fractal->transformCommon.scale1));
			aux->DE = mad(aux->DE, fabs(fractal->mandelbox.scale), 1.0f);
		}
	}
	if (fractal->transformCommon.addCpixelEnabledFalse)
	{
		REAL4 tempC = c;
		if (fractal->transformCommon.alternateEnabledFalse) // alternate
		{
			tempC = aux->c;
			switch (fractal->mandelbulbMulti.orderOfXYZ)
			{
				case multi_OrderOfXYZCl_xyz:
				default: tempC = (REAL4){tempC.x, tempC.y, tempC.z, tempC.w}; break;
				case multi_OrderOfXYZCl_xzy: tempC = (REAL4){tempC.x, tempC.z, tempC.y, tempC.w}; break;
				case multi_OrderOfXYZCl_yxz: tempC = (REAL4){tempC.y, tempC.x, tempC.z, tempC.w}; break;
				case multi_OrderOfXYZCl_yzx: tempC = (REAL4){tempC.y, tempC.z, tempC.x, tempC.w}; break;
				case multi_OrderOfXYZCl_zxy: tempC = (REAL4){tempC.z, tempC.x, tempC.y, tempC.w}; break;
				case multi_OrderOfXYZCl_zyx: tempC = (REAL4){tempC.z, tempC.y, tempC.x, tempC.w}; break;
			}
			aux->c = tempC;
		}
		else
		{
			switch (fractal->mandelbulbMulti.orderOfXYZ)
			{
				case multi_OrderOfXYZCl_xyz:
				default: tempC = (REAL4){c.x, c.y, c.z, c.w}; break;
				case multi_OrderOfXYZCl_xzy: tempC = (REAL4){c.x, c.z, c.y, c.w}; break;
				case multi_OrderOfXYZCl_yxz: tempC = (REAL4){c.y, c.x, c.z, c.w}; break;
				case multi_OrderOfXYZCl_yzx: tempC = (REAL4){c.y, c.z, c.x, c.w}; break;
				case multi_OrderOfXYZCl_zxy: tempC = (REAL4){c.z, c.x, c.y, c.w}; break;
				case multi_OrderOfXYZCl_zyx: tempC = (REAL4){c.z, c.y, c.x, c.w}; break;
			}
		}
		z += tempC * fractal->transformCommon.constantMultiplier111;
	}
	if (fractal->mandelbox.mainRotationEnabled && aux->i >= fractal->transformCommon.startIterationsR
			&& aux->i < fractal->transformCommon.stopIterationsR)
		z = Matrix33MulFloat4(fractal->mandelbox.mainRot, z);

	aux->foldFactor = fractal->foldColor.compFold0; // fold group weight
	aux->minRFactor = fractal->foldColor.compMinR;	// orbit trap weight

	REAL scaleColor = fractal->foldColor.colorMin + fabs(fractal->mandelbox.scale);
	// scaleColor += fabs(fractal->mandelbox.scale);
	aux->scaleFactor = scaleColor * fractal->foldColor.compScale;
	return z;
}