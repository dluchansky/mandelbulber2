/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2017 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * mandelbulbMulti 3D
 */

/* ### This file has been autogenerated. Remove this line, to prevent override. ### */

REAL4 MandelbulbMultiIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	REAL4 c = aux->const_c;

	if (fractal->transformCommon.functionEnabledFalse)
	{
		if (fractal->transformCommon.functionEnabledAxFalse) z.x = fabs(z.x);
		if (fractal->transformCommon.functionEnabledAyFalse) z.y = fabs(z.y);
		if (fractal->transformCommon.functionEnabledAzFalse) z.z = fabs(z.z);
	}
	REAL th0 = fractal->bulb.betaAngleOffset;
	REAL ph0 = fractal->bulb.alphaAngleOffset;
	REAL4 v;

	switch (fractal->mandelbulbMulti.orderOfXYZ)
	{
		case multi_OrderOfXYZCl_xyz:
		default: v = (REAL4){z.x, z.y, z.z, z.w}; break;
		case multi_OrderOfXYZCl_xzy: v = (REAL4){z.x, z.z, z.y, z.w}; break;
		case multi_OrderOfXYZCl_yxz: v = (REAL4){z.y, z.x, z.z, z.w}; break;
		case multi_OrderOfXYZCl_yzx: v = (REAL4){z.y, z.z, z.x, z.w}; break;
		case multi_OrderOfXYZCl_zxy: v = (REAL4){z.z, z.x, z.y, z.w}; break;
		case multi_OrderOfXYZCl_zyx: v = (REAL4){z.z, z.y, z.x, z.w}; break;
	}
	// if (aux->r < 1e-21f)
	//	aux->r = 1e-21f;
	// if (v3 < 1e-21f && v3 > -1e-21f)
	//	v3 = (v3 > 0) ? 1e-21f : -1e-21f;

	if (fractal->mandelbulbMulti.acosOrAsin == multi_acosOrAsinCl_acos)
		th0 += acos(native_divide(v.x, aux->r));
	else
		th0 += asin(native_divide(v.x, aux->r));

	if (fractal->mandelbulbMulti.atanOrAtan2 == multi_atanOrAtan2Cl_atan)
		ph0 += atan(native_divide(v.y, v.z));
	else
		ph0 += atan2(v.y, v.z);

	REAL rp = native_powr(aux->r, fractal->bulb.power - 1.0f);
	REAL th = th0 * fractal->bulb.power * fractal->transformCommon.scaleA1;
	REAL ph = ph0 * fractal->bulb.power * fractal->transformCommon.scaleB1;

	aux->r_dz = mad(rp * aux->r_dz, fractal->bulb.power, 1.0f);
	rp *= aux->r;

	if (fractal->transformCommon.functionEnabledxFalse)
	{ // cosine mode
		REAL sinth = th;
		if (fractal->transformCommon.functionEnabledyFalse) sinth = th0;
		sinth = native_sin(sinth);
		z = rp * (REAL4){sinth * native_sin(ph), native_cos(ph) * sinth, native_cos(th), 0.0f};
	}
	else
	{ // sine mode ( default = V2.07))
		REAL costh = th;
		if (fractal->transformCommon.functionEnabledzFalse) costh = th0;
		costh = native_cos(costh);
		z = rp * (REAL4){costh * native_cos(ph), native_sin(ph) * costh, native_sin(th), 0.0f};
	}

	if (fractal->transformCommon.addCpixelEnabledFalse)
	{
		REAL4 tempC = c;
		if (fractal->transformCommon.alternateEnabledFalse) // alternate
		{
			tempC = aux->c;
			switch (fractal->mandelbulbMulti.orderOfXYZC)
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
			switch (fractal->mandelbulbMulti.orderOfXYZC)
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
		z += tempC * fractal->transformCommon.constantMultiplierC111;
	}
	return z;
}