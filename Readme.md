
## Getting into Object Oriented CSS

 http://www.youtube.com/watch?v=ZpFdyfs03Ug
 http://oocss.org
 http://smacss.com
 http://csslint.net
 http://www.vanseodesign.com/css/object-oriented-css/
 http://www.vanseodesign.com/css/smacss-introduction/
 http://www.vanseodesign.com/css/block-element-modifier/
 http://www.vanseodesign.com/css/scalable-maintainable/

## Block - Element - Modifier

  http://bem.info/method/definitions/

### Base

global resets and normalisation

### Grid

**.g_gridName**

**.g_gridName**__xxx

**.g_gridName**__xxx--yy

global layout details

### Components

**.c_componentName**

**.c_componentName**__xxx

**.c_componentName**__xxx--yy

defines a general item that can be reused over different pages. e.g a button, display panel etc

### Modules

**.m_pageName__moduleName**

**.m_pageName__moduleName**--yy

One off designs. Applicable to only this page/partial (eg header / footer )

### Text

 * defaults.scss
   (fixed to element names eg **A**)
   set base text style for the site per element

* sizes.scss
   **.size-**##
   Small number of font sizes to be dropped in to elements

* styles.scss
   **.style-**xxxx
   Any groups of font style (font, colour, weight etc) that are not size

# Naming & file name conventions

**.a-cccc__xxx--yy**

**.a(-bbbb)_\_cccc__xxx--yy**


### .a
the first letter of the sass group

### -bbbb
For modules, the page name.

file: /modules/bbbb.scss

### -cccc
the oject name

file: /sass_group/cccc.scss

### __xxx
a child of the object. e.g. if the object is 'list' a child could be 'item'.

	<div class="c-form" >
		<form action="submit.php" >
			First name: <input type="text" class="c-form__textBox" >
			<input type="submit" style="c-form__button" >
		</form>
	</div>


### --yy
Modifies the object. so **c-button--red** would colour the button red.
The html would look like:

	<button class="c-button c-button--red">



### Naming conventions

  https://gist.github.com/necolas/1309546

### Influences

  https://github.com/csswizardry/inuit.css


