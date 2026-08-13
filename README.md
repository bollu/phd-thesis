# Sid's PhD Thesis


--------


# Usage details


## Class options

`cam-thesis` supports all the options of the standard `report` class (on which
it is based).

It also supports some custom options.

*   `techreport`: formats the document as a technical report (here's
    [a sample](https://cam-thesis.s3-eu-west-1.amazonaws.com/pdf/techreport.pdf)).
    Here is a list of
    formatting points in which the technical report differs from a normal thesis
    (see [guidelines](http://www.cl.cam.ac.uk/techreports/submission.html) for
    more information):

    *   different margins (left and right margins are 25mm, top and bottom
        margins are 20mm),
    *   normal line spacing (instead of one-half spacing),
    *   no custom title page,
    *   no declaration,
    *   page count starts with 3,
    *   if the `hyperref` package is used, the option `pdfpagelabels=false` will
        be passed to it.

*   `firstyr`: formats the document as a first-year report (here's
    [a sample](https://cam-thesis.s3-eu-west-1.amazonaws.com/pdf/firstyr.pdf)). This option removes
    some unneeded elements and modifies the submission note. Here is a list of
    formatting points in which the first year report differs from a normal thesis:

    *   an appropraite subtitle is added,
    *   the submission note is changed appropriately,
    *   no standalone abstract,
    *   no declaration,
    *   no acknowledgements.

*   `secondyr`: formats the document as a second-year report (here's
    [a sample](https://cam-thesis.s3-eu-west-1.amazonaws.com/pdf/secondyr.pdf)). Similarly to
	`firstyr`, this style modifies the submission note and removes unneeded elements.
    Specially, an abstract is retained (as for this report, research is often in a
	more "stable" state). Here is a list of formatting points in which the second year
	report differs from a normal thesis:

    *   an appropraite subtitle is added,
    *   the submission note is changed appropriately,
    *   no declaration,
    *   no acknowledgements.

*   `times`: tells the class to use the _times_ font.

*   `glossary`: puts the glossary after the TOC. The glossary contains a list of
    abbreviations, their explanations etc. Describe your abbreviations and add
    them to the glossary immediately after you introduce them in the body of
    your thesis. You can use the following command for this:

        \newglossaryentry{computer}
        {
          name=computer,
          description={is a programmable machine that receives input,
                       stores and manipulates data, and provides
                       output in a useful format}
        }

    After that, you can reference particular glossary entries like this:

        \gls{computer}

    You can also change the glossary style. For example, try putting this on the very top of the preamble (even before you define the document class with `\documentclass[glossary]{cam-thesis}`):

        \PassOptionsToPackage{style=altlong4colheader}{glossaries}

    Further instructions can be found [on LaTeX Wikibooks](http://en.wikibooks.org/wiki/LaTeX/Glossary) or the [user manual at CTAN](http://mirrors.ctan.org/macros/latex/contrib/glossaries/glossaries-user.pdf).

    _Note_: `glossaries` is the package used to create the glossary.

*   `withindex`: build the index, which you can put at the and of the thesis with
     the following command (it will create a new unnumbered chapter):

        \printthesisindex

    Instructions on how to use the index can be found [here](http://en.wikibooks.org/wiki/LaTeX/Indexing#Using_makeidx).

    _Note_: the package `makeidx` is used to create the index.

*   `backrefs`: Add back references in the References section (here's
    [a sample](https://cam-thesis.s3-eu-west-1.amazonaws.com/pdf/backrefs.pdf)). In other words, for each reference, it adds the page(s) where it is cited.

    _Note_: the package `backref` is used to create the back references.

-------------------------------------------------------------------------------


## _Q2_: Where can I find the thesis formatting guidelines this class is based on?

The University of Cambridge submission guidelines:

> [https://www.cambridgestudents.cam.ac.uk/your-course/examinations/graduate-exam-information/submitting-and-examination/phd-msc-mlitt/submit](https://www.cambridgestudents.cam.ac.uk/your-course/examinations/graduate-exam-information/submitting-and-examination/phd-msc-mlitt/submit)

The University of Cambridge final submission guidelines:

> [https://www.cambridgestudents.cam.ac.uk/your-course/examinations/graduate-exam-information/after-examination/degree-approval-and-1](https://www.cambridgestudents.cam.ac.uk/your-course/examinations/graduate-exam-information/after-examination/degree-approval-and-1)

The Computer Laboratory guidelines:

> [https://www.cl.cam.ac.uk/local/typography/phd/](https://www.cl.cam.ac.uk/local/typography/phd/)

The Computer Laboratory guidelines for technical reports:

> [https://www.cl.cam.ac.uk/techreports/submission.html](https://www.cl.cam.ac.uk/techreports/submission.html)


## _Q5_: Where can I find newer versions of the University of Cambridge logo?

The university updates its logo every now and then. You can find up-to-date
logos on [this page](https://www.cam.ac.uk/brand-resources/about-the-logo/logo-downloads)
(subject to change without notice).

Download and exchange the new logos with `CUni.eps` and/or `CUni.pdf`.


## _Q8_: How should I count the number of words in my thesis?

There is [a page](http://www.cl.cam.ac.uk/local/phd/writingup.html) on the Computer Lab's web site. They recommend using this command:

    ps2ascii thesis.pdf | wc -w


## _Q9_: How can I change the College Shield?

In `thesis.tex` use `\collegeshield{CollegeShields/<college>}` with `<college>` as your your desired college name, as found in `CollegeShields`.

Alternatively, `\collegeshield{CollegeShields/CUniNoText}` can be used to display the University of Cambridge shield design.

