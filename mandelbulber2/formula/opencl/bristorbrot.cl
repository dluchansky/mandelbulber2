/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2018 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * Bristorbrot formula
 * @reference http://www.fractalforums.com/theory/bristorbrot-3d/
 * by Doug Bristor

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the file "fractal_bristorbrot.cpp" in the folder formula/definition
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 BristorbrotIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	Q_UNUSED(fractal);

	aux->DE = aux->DE * 2.0f * aux->r;
	REAL newx = mad(-z.z, z.z, mad(z.x, z.x, -z.y * z.y));
	REAL newy = z.y * (mad(2.0f, z.x, -z.z));
	REAL newz = z.z * (mad(2.0f, z.x, z.y));
	z.x = newx;
	z.y = newy;
	z.z = newz;
	return z;
}