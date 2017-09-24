/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2017 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * Menger Prism Shape
 * from code by Knighty
 * http://www.fractalforums.com/fragmentarium/cross-menger!-can-anyone-do-this/msg93972/#new
 */

/* ### This file has been autogenerated. Remove this line, to prevent override. ### */

REAL4 MengerPrismShapeIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	REAL4 gap = fractal->transformCommon.constantMultiplier000;
	REAL t;
	REAL dot1;

	if (aux->i >= fractal->transformCommon.startIterationsP
			&& aux->i < fractal->transformCommon.stopIterationsP1)
	{
		z.y = fabs(z.y);
		z.z = fabs(z.z);
		dot1 = (mad(z.x, -SQRT_3_4, z.y * 0.5f)) * fractal->transformCommon.scale;
		t = max(0.0f, dot1);
		z.x -= t * -SQRT_3;
		z.y = fabs(z.y - t);

		if (z.y > z.z)
		{
			REAL temp = z.y;
			z.y = z.z;
			z.z = temp;
		}
		z -= gap * (REAL4){SQRT_3_4, 1.5f, 1.5f, 0.0f};
		// z was pos, now some points neg (ie neg shift)
		if (z.z > z.x)
		{
			REAL temp = z.z;
			z.z = z.x;
			z.x = temp;
		}
		if (z.x > 0.0f)
		{
			z.y = max(0.0f, z.y);
			z.z = max(0.0f, z.z);
		}
	}

	if (fractal->transformCommon.functionEnabledRFalse
			&& aux->i >= fractal->transformCommon.startIterationsR
			&& aux->i < fractal->transformCommon.stopIterationsR)
		z = Matrix33MulFloat4(fractal->transformCommon.rotationMatrix, z);

	if (fractal->transformCommon.benesiT1EnabledFalse
			&& aux->i >= fractal->transformCommon.startIterations
			&& aux->i < fractal->transformCommon.stopIterationsT1)
	{
		REAL tempXZ = mad(z.x, SQRT_2_3, -z.z * SQRT_1_3);
		z = (REAL4){
			(tempXZ - z.y) * SQRT_1_2, (tempXZ + z.y) * SQRT_1_2, z.x * SQRT_1_3 + z.z * SQRT_2_3, z.w};

		REAL4 temp = z;
		REAL tempL = length(temp);
		z = fabs(z) * fractal->transformCommon.scale3D222;
		// if (tempL < 1e-21f) tempL = 1e-21f;
		REAL avgScale = native_divide(length(z), tempL);
		aux->r_dz *= avgScale;
		aux->DE = mad(aux->DE, avgScale, 1.0f);

		tempXZ = (z.y + z.x) * SQRT_1_2;

		z = (REAL4){z.z * SQRT_1_3 + tempXZ * SQRT_2_3, (z.y - z.x) * SQRT_1_2,
			z.z * SQRT_2_3 - tempXZ * SQRT_1_3, z.w};
		z = z - fractal->transformCommon.offset200;
	}

	if (fractal->transformCommon.functionEnabledxFalse
			&& aux->i >= fractal->transformCommon.startIterationsD
			&& aux->i < fractal->transformCommon.stopIterationsTM1)
	{
		REAL tempXZ = mad(z.x, SQRT_2_3, -z.z * SQRT_1_3);
		z = (REAL4){
			(tempXZ - z.y) * SQRT_1_2, (tempXZ + z.y) * SQRT_1_2, z.x * SQRT_1_3 + z.z * SQRT_2_3, z.w};

		REAL4 temp = z;
		REAL tempL = length(temp);
		z = fabs(z) * fractal->transformCommon.scale3D333;
		// if (tempL < 1e-21f) tempL = 1e-21f;
		REAL avgScale = native_divide(length(z), tempL);
		aux->r_dz *= avgScale;
		aux->DE = mad(aux->DE, avgScale, 1.0f);

		z = (fabs(z + fractal->transformCommon.additionConstant111)
				 - fabs(z - fractal->transformCommon.additionConstant111) - z);

		tempXZ = (z.y + z.x) * SQRT_1_2;

		z = (REAL4){z.z * SQRT_1_3 + tempXZ * SQRT_2_3, (z.y - z.x) * SQRT_1_2,
			z.z * SQRT_2_3 - tempXZ * SQRT_1_3, z.w};
	}
	if (fractal->transformCommon.functionEnabledFFalse
			&& aux->i >= fractal->transformCommon.startIterationsF
			&& aux->i < fractal->transformCommon.stopIterationsF)
	{
		REAL4 tempA, tempB;

		if (fractal->transformCommon.functionEnabledAx)
			tempA.x = fabs(z.x + fractal->transformCommon.offsetF000.x);

		if (fractal->transformCommon.functionEnabledx)
			tempB.x = fabs(z.x - fractal->transformCommon.offset000.x);

		z.x = tempA.x - tempB.x - (z.x * fractal->transformCommon.scale3D111.x);

		if (fractal->transformCommon.functionEnabledAy)
			tempA.y = fabs(z.y + fractal->transformCommon.offsetF000.y);

		if (fractal->transformCommon.functionEnabledy)
			tempB.y = fabs(z.y - fractal->transformCommon.offset000.y);

		z.y = tempA.y - tempB.y - (z.y * fractal->transformCommon.scale3D111.y);

		if (fractal->transformCommon.functionEnabledAz)
			tempA.z = fabs(z.z + fractal->transformCommon.offsetF000.z);

		if (fractal->transformCommon.functionEnabledz)
			tempB.z = fabs(z.z - fractal->transformCommon.offset000.z);

		z.z = tempA.z - tempB.z - (z.z * fractal->transformCommon.scale3D111.z);

		z += fractal->transformCommon.offsetA000;
	}
	if (fractal->transformCommon.functionEnabled
			&& aux->i >= fractal->transformCommon.startIterationsM
			&& aux->i < fractal->transformCommon.stopIterationsM)
	{
		z = fabs(z);
		if (z.x - z.y < 0.0f)
		{
			REAL temp = z.y;
			z.y = z.x;
			z.x = temp;
		}
		if (z.x - z.z < 0.0f)
		{
			REAL temp = z.z;
			z.z = z.x;
			z.x = temp;
		}
		if (z.y - z.z < 0.0f)
		{
			REAL temp = z.z;
			z.z = z.y;
			z.y = temp;
		}
		z *= fractal->transformCommon.scale3;
		z.x -= 2.0f * fractal->transformCommon.constantMultiplierA111.x;
		z.y -= 2.0f * fractal->transformCommon.constantMultiplierA111.y;
		if (z.z > 1.0f) z.z -= 2.0f * fractal->transformCommon.constantMultiplierA111.z;
		aux->DE *= fractal->transformCommon.scale3 * fractal->transformCommon.scaleA1;

		z += fractal->transformCommon.additionConstantA000;
	}

	aux->DE *= fractal->transformCommon.scaleB1;
	return z;
}