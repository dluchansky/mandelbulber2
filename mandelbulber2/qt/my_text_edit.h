/*
 * my_text_edit.h
 *
 *  Created on: 30 mar 2020
 *      Author: krzysztof
 */

#ifndef MANDELBULBER2_QT_MY_TEXT_EDIT_H_
#define MANDELBULBER2_QT_MY_TEXT_EDIT_H_

#include <QTextEdit>
class Highlighter;

class cMyTextEdit : public QTextEdit
{
	Q_OBJECT

public:
	explicit cMyTextEdit(QWidget *parent = nullptr);
	;
	~cMyTextEdit();

private:
	Highlighter *highlighter;
};

#endif /* MANDELBULBER2_QT_MY_TEXT_EDIT_H_ */
