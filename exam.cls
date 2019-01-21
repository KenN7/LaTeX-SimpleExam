\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{exam}[31/05/2016 Classe pour les examens, V0.1]

% classe de base

\LoadClass[a4paper,12pt]{article}

% extensions
%\RequirePackageWithOptions{babel}
%\RequirePackage[frenchb,english]{babel}
\RequirePackage{lastpage}
\RequirePackage{fancyhdr}% en têtes
%\RequirePackage{datetime}
\RequirePackage{hyperref}
\RequirePackage{ifthen}
\RequirePackage{amsthm}
\RequirePackage{color}
\RequirePackage{totcount} %faire le total des points des questions
\RequirePackage[top=1 in, bottom=1 in, left=1 in, right=1 in]{geometry}
\RequirePackage{tcolorbox}
\RequirePackage{pgffor}
\RequirePackage{graphicx}
\RequirePackage{tikz}
\RequirePackage{needspace}
\RequirePackage{fp}

% conf de fancyhdr
\fancyhfoffset[ERLO]{0cm} %header with full page width
\setlength{\headheight}{52pt}

\widowpenalty=1000 %dirty hack, as usual, avoid widows and orphans
\clubpenalty=10000
\pagestyle{fancy}
\setlength{\parskip}{0.5cm plus4mm minus3mm} %espacement entre §
\setlength{\parindent}{0pt}

% conf counters
\newtotcounter{Qcount}
\newtotcounter{totdraft}
\FPset\TotalPoints{0}

%mark label
\makeatletter
\newcommand{\myLabel}[2]{%
  \def\@currentlabel{#2}% Update label
  \label{#1}
}
\makeatother

%change date
\newcommand{\changedate}[3]
{
    \renewcommand{\day}{#1}
    \renewcommand{\month}{#2}
    \renewcommand{\year}{#3}
}

% lang
\def \langu {frenchb}
\newcommand{\langexam}[1]
{
    \def \langu {#1}
    %\selectlanguage{#1}
    %\ExecuteOptions{#1}
}

% corrige ou non

\newboolean{corrige}
\setboolean{corrige}{false}
\newcommand{\correction}[1]
{
    \ifthenelse {\boolean{#1}}
        {\setboolean{corrige}{true}}
        {\setboolean{corrige}{false}}
}

% name of exam

\newcommand{\toptitle}[2]
{
    \lhead{#1 \\ #2}
    \chead{\ifthenelse{\boolean{corrige}}{Corrig\'e}{}}
    \rhead{\today\\page : \thepage}
    %\rhead{\longdate\displaydate{date}\\page : \thepage}
    \cfoot{}
    \pdfinfo{
    /Title (#1, Exam)
    }
    \hypersetup{
    pdftitle={#1},
    pdfsubject={Exam}
    }
}

%author
\renewcommand{\author}[1]
{
    \hypersetup{
    pdfauthor={#1}
    }
    \pdfinfo{
    /Author (#1)
    }
}

% Article 88 box
\newboolean{includeArtRGE}
\setboolean{includeArtRGE}{false}
\newcommand{\artRGE}[1]
{
        \setboolean{includeArtRGE}{true}
        \begin{minipage}{.43\textwidth}
            \input{#1}
        \end{minipage}
}


% name box
\newcommand{\namebox}[1]
{
    \ifthenelse{\boolean{includeArtRGE}}
    {
        \begin{minipage}{.47\textwidth}
    }{}
    \begin{flushright}
    \begin{large}
    \textbf{\begin{tabular}{|rp{5cm}|}
    \hline
    & \\
    %\ifthenelse{\equal{\languagename}{english}}%
    \ifthenelse{\equal{\langu}{english}}%
    %\iflanguage{english}%
    {
        \ifthenelse{\equal{#1}{name}}
        {
            \textsc{Firstname} : &  \\ & \\%
            \textsc{Lastname} : &  \\ & \\%
        }{
        \ifthenelse{\equal{#1}{section}}
        {
            \textsc{Firstname} : &  \\ & \\%
            \textsc{Lastname} : &  \\ & \\%
            \textsc{Department }: &  \\ & \\%
        }{
        \ifthenelse{\equal{#1}{full}}
        {
            \textsc{Firstname} : &  \\ & \\%
            \textsc{Lastname} : &  \\ & \\%
            \textsc{Department }: &  \\ & \\%
            \textsc{Student id} : &  \\ & \\%
        }{}}}
    }
    {
        \ifthenelse{\equal{\langu}{frenchb}}%
        %\iflanguage{frenchb}%
        %\ifthenelse{\equal{\languagename}{frenchb}}%
        {
            \ifthenelse{\equal{#1}{name}}
            {
                \textsc{Nom} : &  \\ & \\%
                \textsc{Pr\'enom} : & \\ & \\%
            }{
            \ifthenelse{\equal{#1}{section}}
            {
                \textsc{Nom} : &  \\ & \\%
                \textsc{Pr\'enom} : & \\ & \\%
                \textsc{Section }: &  \\ & \\%
            }{
            \ifthenelse{\equal{#1}{full}}
            {
                \textsc{Nom} : &  \\ & \\%
                \textsc{Pr\'enom} : & \\ & \\%
                \textsc{Section }: &  \\ & \\%
                \textsc{\No \'etudiant(e)} : &  \\ & \\%
            }{}}}
        }{}
    }
    \hline
    \end{tabular}}
    \end{large}

    \end{flushright}
    \ifthenelse{\boolean{includeArtRGE}}
    {
        \end{minipage}
    }{}
}


% front page
\newcommand{\frontpage}[1]
{
\input{#1}
}

% commandes personnelles

\definecolor{darkblue}{rgb}{0,0,0.5}
\definecolor{light-gray}{gray}{0.8}
\theoremstyle{definition}% questions pas en italique

\newtheorem{Q}[]{Question}[section]
\newtheoremstyle{Q}{3pt}{3pt}{}{}{}{~:}{\newline}{}

\tcbuselibrary{breakable,skins}

\newcommand{\Question}[4]
{%
    \Needspace{5\baselineskip}%
	\begin{Q}\ %\rule{0pt}{0.1cm}%
    \vspace*{-0.2cm}%
    \begin{tcolorbox}[breakable,colback=white,
        enlarge top at break by=1.8em,arc=0.5mm,
        extras middle and last={overlay={
        \begin{tcbclipinterior}
        \draw (interior.north west) node [anchor=north west,
        yshift=1.8em,xshift=-0.06cm,scale=1,inner sep=0,outer sep=0]
        {\textbf{Question~\theQ%
        \ifthenelse{\equal{\langu}{frenchb}}%
        {~suite.}%
        {%
            \ifthenelse{\equal{\langu}{english}}%
            {~next~part.}%
            {}%
        }%
        }};
    \end{tcbclipinterior}
        }}]
		\ifthenelse {\boolean{corrige}}
        {
            \ifthenelse{\equal{\langu}{english}}%
            {
                #3\par
                \paragraph{Answer:}~\\ \color{darkblue} \small #4
                \color{black}
                \normalsize
            }
            {
                \ifthenelse{\equal{\langu}{frenchb}}%
                {
                    #3\par
                    \paragraph{R\'eponse :}~\\ \color{darkblue} \small #4
                    \color{black}
                    \normalsize
                }
            }
        }
        {
            #3\par%
            %\tcblower
            \foreach \x in {1,...,#1}%
            %{\strut\par}
            {\rule{0pt}{1cm-\parskip}\par}
        }
		%\ifthenelse{#2>0}
        \FPifgt{#2}{0}
		{%
        \begin{flushright}
			/#2%\vspace{0.1Em}
			%\FPadd\TotalPoints\TotalPoints{#2}
            \FPeval{\TotalPoints}{\TotalPoints+#2}
			%\addtocounter{TotalPoints}{#2} %compte les points
			\addtocounter{Qcount}{1} %compte les questions
            \FPifint\TotalPoints{% #1 is integer ?
                \FPeval{\TotalPoints}{round(TotalPoints:0)}
                \global\let\TotalPoints\TotalPoints % keep changes upstream
            }
            \else{
                \FPeval{\TotalPoints}{round(TotalPoints:1)}
                \global\let\TotalPoints\TotalPoints % keep changes upstream
            }\fi
            \myLabel{totpoints}{\TotalPoints}
		\end{flushright}
		}
        \else
		{}%else
        \fi
		%\end{minipage}
    \end{tcolorbox}
    \end{Q}

}

\newcommand{\examtitle}[2]
{
    \begin{center}
    \begin{huge}
    \textbf{#1~\\
    #2
    \ifthenelse{\boolean{corrige}}{\\\vspace*{2mm}Corrig\'e}{}}
    \end{huge}
    \end{center}%
}

\newcommand{\addgrid}[3]
{
\begin{center}
\begin{tikzpicture}
\draw[step=0.5cm,gray] (0,0) grid (#1,#2);
\ifthenelse{\equal{#3}{axes}}
{
\draw[thick,->] (#1/2-#1/2,#2/2) -- (#1/2+#1/2,#2/2) node[anchor=north west] {};
\draw[thick,->] (#1/2,#2/2-#2/2) -- (#1/2,#2/2+#2/2) node[anchor=north west] {};
}{}
\end{tikzpicture}
\end{center}
}


\newcommand{\adddraft}[2]
{
\foreach \y in {1,...,#1}
{
    \addtocounter{totdraft}{1}
    \ifthenelse{\equal{#2}{grid}}
    {
        \newpage
        \hspace{-1.65cm}
        \ifthenelse{\equal{\langu}{english}}%
        {
            \begin{tikzpicture}
            \draw[step=0.5cm,gray,very thin] (0,0) grid (19,25);
            \node[rotate=0,scale=4.5,text opacity=0.25,anchor=center] at (9.5,1) {Detachable draft};
            \end{tikzpicture}
        }
        {
            \ifthenelse{\equal{\langu}{frenchb}}%
            {
                \begin{tikzpicture}
                \draw[step=0.5cm,gray,very thin] (0,0) grid (19,25);
                \node[rotate=0,scale=4.5,text opacity=0.25,anchor=center] at (9.5,1) {Brouillon d\'etachable};
                \end{tikzpicture}
            }{}
        }
    }
    {
    \newpage
    \hspace{-1.65cm}
    \begin{tikzpicture}[remember picture,overlay]
    %\draw[step=0.5cm,gray,very thin] (0,0) grid (19,25);
    \node[rotate=0,scale=4.5,text opacity=0.25,anchor=south] at ([yshift=0.5cm]current page.south) {Brouillon d\'etachable};
    \end{tikzpicture}
    }
}
}
