% =======================================================
% SimpleResume.cls
% Copyright 2022 Yifan ZHANG
% 
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either
% version 1.3 of this license or (at your option) any 
% later version. The latest version of this license is
% in http://www.latex-project.org/lppl.txt and version 
% 1.3 or later is part of all distributions of LaTeX
% version 2005/12/01 or later.
%
% This work has the LPPL maintenance status `maintained'.
% 
% The Current Maintainer of this work is Yifan Zhang.
%
% This work consists of the file SimpleResume.cls and
% example.tex.
% 
% =======================================================
% 
% Acknowledgment
% 
% I would like express my special thanks to Professor
% Xiao Ma for helping my coding and encouraging this 
% project; Guomin Xing for helping the improvement of the
% project.
% 
% =======================================================
% 
% 版本日志：
%   v1.0
%     * 初始版本
%   v1.1
%     * 修复bug：换行符产生多余空格
%     * 添加模块：细节清单（表格内列表）
%   v1.2_beta
%     * 可以在简历右上角添加照片
%     * 优化个人信息部分的宽度计算方式
%     * 优化代码对齐
%     * 添加致谢
%   v1.2
%     * 单条个人信息可以占2列或3列宽
%     * 添加模块：时间轴或表单里的小格子
%     * 优化时间轴和表单模块的对齐方式
%     * 修复bug：不指定\photo就报错
%     * 添加版本日志
%     * 新增GitHub、GitLab个人信息标签
% 
% =======================================================
% 
% 索引（可搜索找到对应代码）：
%   一、基本信息
%   二、全局设置
%     页面设置
%     配置颜色
%     设置西文字体
%     设置中文字体
%   三、通用模块
%     在导言区定义个人信息
%     基本元素
%     个人信息模块
%     模块标题
%     时间轴和表单
%     时间轴或表单里的小格子
%     列表
%     细节清单（表格内列表）
%     多段文本
%     末页页脚
%   四、定制模块
%     定制的个人信息标签
%     定制的模块标题
%   五、其他设置
%     超链接设置
% =======================================================

% ============
% 一、基本信息
% ============

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{SimpleResume}[%
    2022/08/10 v1.2 A Simple \LaTeX Résumé / CV Template.%
]

% ============
% 二、全局设置
% ============

% 页面设置
\LoadClass{article}        % 继承article类
\RequirePackage[
    fontsize = 10pt
]{fontsize}                % 全局字号
\RequirePackage[
    a4paper, margin=0.75in
]{geometry}                % 设置纸张、页边距
\RequirePackage{indentfirst}
\setlength\parindent{0em}  % 设置缩进
\linespread{1.3}           % 行距
\pagestyle{empty}          % 设置页面风格

% 配置颜色
\RequirePackage{xcolor}
\definecolor{Main}{cmyk}{1, 0.6, 0, 0.5}

% 设置西文字体
\RequirePackage{fontspec}
    \setmainfont[       % 西文默认字体
        Path           = fonts/,
        BoldFont       = EBGaramond-Bold,
        ItalicFont     = EBGaramond-Italic,
        BoldItalicFont = EBGaramond-BoldItalic,
    ]{EBGaramond-Regular}
    \setsansfont[       % 西文无衬线字体
        Path           = fonts/,
        BoldFont       = NotoSans-Bold,
        ItalicFont     = NotoSans-Italic,
        BoldItalicFont = NotoSans-BoldItalic,
    ]{NotoSans-Regular}
    \setmonofont[       % 西文等宽字体
        Path           = fonts/,
        BoldFont       = Inconsolata-ExtraBold,
        ItalicFont     = Inconsolata-Medium,
        BoldItalicFont = Inconsolata-ExtraBold,
    ]{Inconsolata-Medium}

% 设置中文字体
\RequirePackage{xeCJK}
    \xeCJKsetup{%       % 标点符号样式，详见xeCJK宏包手册
        PunctStyle = kaiming%
    }
    \setCJKmainfont[    % 中文默认字体
        Path           = fonts/,
        BoldFont       = NotoSerifSC-Black,
        ItalicFont     = NotoSerifSC-ExtraLight,
        BoldItalicFont = NotoSerifSC-SemiBold,
    ]{NotoSerifSC-Regular}
    \setCJKsansfont[    % 中文无衬线字体
        Path           = fonts/,
        BoldFont       = NotoSansSC-Bold,
        ItalicFont     = NotoSansSC-Regular,
        BoldItalicFont = NotoSansSC-Bold,
    ]{NotoSansSC-Regular}
    \setCJKmonofont[    % 中文等宽字体
        Path           = fonts/,
        BoldFont       = NotoSansSC-Bold,
        ItalicFont     = NotoSansSC-Regular,
        BoldItalicFont = NotoSansSC-Bold,
    ]{NotoSansSC-Regular}

% ============
% 三、通用模块
% ============

% 在导言区定义个人信息
\newcommand\name[2]{%    % 中文姓名和英文姓名
    \def\@nameCJK{#1}
    \def\@nameEn{#2}
}
\newcommand\bio[1]{%     % 其他个人信息
    \def\@bio{\raggedright #1}
}
\def\@photopath{}
\newcommand\photo[2]{%   % 照片
    \def\@photopath{#1}
    \def\@photowidth{#2}
}

% 基本元素
\RequirePackage{fontawesome5}
\RequirePackage{ifthen}
\RequirePackage{setspace}
\newcommand\icon[1]{%     % 图标
    \makebox[1.5em]{\textcolor{Main}{#1}}%
}
\newcommand\tag[2]{%      % 带图标的小标签
    \mbox{\icon{#1}#2}%
}
\newcommand\iconini[1]{%  % 未指定颜色的图标
    \makebox[1.5em]{#1}%
}
\newcommand\tagini[2]{%   % 未指定图标颜色的小标签
    \mbox{\iconini{#1}#2}%
}
\newcommand\info[3][1]{%      % 个人信息标签
    \ifthenelse{%             % 判断标签宽度
        \equal{#1}{1}%
    }{%                       % 默认为1列
        \begin{minipage}{0.31\textwidth}
            \vspace{-1ex}     % 抵消setspace的一个小bug
            \newcommand\@infowidth{\textwidth}
            \addtolength{\@infowidth}{-1.5em}
            \addtolength{\@infowidth}{-0.05\textwidth}
            \begin{singlespacing}
                \parbox{1.5em}{%
                    \icon{#2}%
                }
                \parbox{\@infowidth}{%
                    \textcolor{Main}{#3}%
                }             % 都用parbox，保证基线对齐
            \end{singlespacing}
        \end{minipage}
    }{%                       % 若不是1列
        \begin{minipage}{0.31\textwidth}
            \vspace{-1ex}     % 抵消setspace的一个小bug
            \newcommand\@infowidth{\textwidth}
            \addtolength{\@infowidth}{-1.5em}
            \addtolength{\@infowidth}{-0.05\textwidth}
            \begin{singlespacing}
                \makebox[1.5em][c]{%
                    \icon{#2}%
                }
                \makebox[\@infowidth][l]{%
                    \textcolor{Main}{#3}%
                }             % 都用makebox，保证基线对齐
            \end{singlespacing}%
        \end{minipage}
        \ifthenelse{%
            \equal{#1}{2}%
        }{%                       % 若为2列，加一个占位
            \begin{minipage}{0.31\textwidth}%
                \hspace{0em}%
            \end{minipage}
        }{%                       % 其他值，视作3列，加两个占位
            \begin{minipage}{0.31\textwidth}%
                \hspace{0em}%
            \end{minipage}
            \begin{minipage}{0.31\textwidth}%
                \hspace{0em}%
            \end{minipage}
        }%
    }%
}

% 个人信息模块
\RequirePackage{ifthen}
\RequirePackage{graphicx}
\newcommand\printname{%     % 显示简历标题
    \color{Main}{%
        \huge
        \ifthenelse{%       % 判断是否输入了中文姓名
            \equal{\@nameCJK}{}%
        }{%
        }{%
            \textsf{\textbf{\@nameCJK}}\par
        }
        \ifthenelse{%       % 判断是否输入了英文姓名
            \equal{\@nameEn}{}%
        }{%
        }{%
            \scshape{\textbf{\@nameEn}}\par%
        }
        \vspace{2ex}\par
    }
}
\newcommand\makeheader{%                  % 生成个人信息模块
    \begin{minipage}{\textwidth}
        \huge\vspace{3ex}\par\normalsize  % 页首空白
        \ifthenelse{%                     % 判断是否指定了照片
            \equal{\@photopath}{}%
        }{%                               % 未指定照片的情况
            \printname
            \@bio
            \vspace{2ex}%
        }{%                               % 指定了照片的情况
            \ifthenelse{%
                \equal{\@photowidth}{}%
            }{%                           % 默认照片宽度
                \renewcommand\@photowidth{3cm}
            }{%
            }
            \newcommand\@biowidth{\textwidth}
            \addtolength{\@biowidth}{-\@photowidth}
            \addtolength{\@biowidth}{-0.01\textwidth}
            \begin{minipage}{\@biowidth}
                \printname
                \@bio
            \end{minipage}
            \begin{minipage}{\@photowidth}
                \centering
                \includegraphics[width=\textwidth]{\@photopath}
            \end{minipage}
        }%
    \end{minipage}%
}

% 模块标题
\RequirePackage{titlesec}
\titleformat{\section}{%         % 修改基础标题样式 
        \vspace{0.5ex}%          % 上边距
        \sffamily\Large\raggedright%
    }%                           % 字体字号、左对齐
    {}%                          % 可添加前缀
    {0em}%                       % 缩进
    {}%                          % 可插入代码
    [\titlerule\vspace{0.5ex}]   % 下加横线
\newcommand\module[2]{%          % 定制module标题样式
    \section{\texorpdfstring{%
        \color{Main}%
        {\hspace{0.2em}\icon{#2} \textbf{#1}}%
    }{#1}}%                      % PDF书签样式
}

% 时间轴和表单
\RequirePackage{array}
\RequirePackage{longtable}
\setlength\LTpre{0em}        % 取消长表和前文的间距
\newenvironment{timeline}{%  % 时间轴环境
    \begin{longtable}{%
        p{0.20\textwidth}<{\raggedleft}|%
        p{0.75\textwidth}<{}%
    }%                       % 设置两列的列宽
}{
    \end{longtable}
    \vspace{2ex}%            % 下边距
}
\newenvironment{form}{%      % 表单样式
    \begin{longtable}{%
        p{0.20\textwidth}<{\raggedleft}%
        p{0.75\textwidth}<{}%
    }%                       % 设置两列的列宽
}{%
    \end{longtable}
    \vspace{2ex}%            % 下边距
}
\newcommand\event[2]{%       % 时间轴或表单上的事件
    \sffamily{\textbf{#1}} & #2 \\%
}

% 时间轴或表单里的小格子
\newcommand\cell[2][1/3]{%     % 定义一个单元格
    \ifthenelse{%
        \equal{#1}{1/3}%
    }{%                        % 默认宽度：1/3
        \makebox[0.24\textwidth][l]{#2}%
    }{\ifthenelse{%
        \equal{#1}{1/4}%
    }{%                        % 宽度：1/4
        \makebox[0.18\textwidth][l]{#2}%
    }{\ifthenelse{%
        \equal{#1}{1/2}%
    }{%                        % 宽度：1/2
        \cell[1/4]{#2}%
        \cell[1/4]{}%
    }{\ifthenelse{%
        \equal{#1}{2/3}%
    }{%                        % 宽度：2/3
        \cell[1/3]{#2}%
        \cell[1/3]{}%
    }{\ifthenelse{%
        \equal{#1}{3/4}%
    }{%                        % 宽度：3/4
        \cell[1/4]{#2}%
        \cell[1/4]{}%
        \cell[1/4]{}%
    }{%                        % 默认宽度：1/3
        \makebox[0.22\textwidth][l]{#2}%
    }}}}}%
}

% 列表
\RequirePackage{enumitem}
\setlist[itemize]{               % 无序列表
    label      = \faAngleRight,  % 标签的样式
    itemsep    = 0em,            % 取消item之间间距
    parsep     = 0em,            % 取消item内部段落间距
    leftmargin = 4em,            % 左边距
    topsep     = 0em,            % 上下边距
    partopsep  = 0em,            % 段首额外上下边距
}
\setlist[enumerate]{        % 有序列表
    itemsep    = 0em,       % 取消item之间间距
    parsep     = 0em,       % 取消item内部段落间距
    leftmargin = 4em,       % 左边距
    topsep     = 0em,       % 上下边距
    partopsep  = 0em,       % 段首额外上下边距
}

% 细节清单（表格内列表）
\newenvironment{details}{%
    \begin{itemize}[
        leftmargin = 2em,
        partopsep  = -1.5em,
    ]%
}{%
    \end{itemize}
    \vspace{0em}%   % 不知道原理是什么，但必须加这行
}

% 多段文本
\newenvironment{pars}{%      % 多段文本环境
    \setlength\parindent{2em}%
    \noindent%               % 首段不缩进
}{%
    \setlength\parindent{0em}%
}
\newenvironment{parsCJK}{%   % 多段中文文本环境
    \setlength\parindent{2em}%
}{%
    \setlength\parindent{0em}%
}

% 末页页脚
\def\@LastPageFooter{%   % 设置末页页脚内容
    \tagini{\faCopyright}      {2022 Yifan ZHANG.}
    \tagini{\faCreativeCommons}{BY 4.0.}
    \tagini{\faEdit}           {\today.}
}
\def\ps@LastPage{%       % 定义末页风格
    \def\@oddfoot{%      % 正面
        \textcolor{gray}{%
            \footnotesize\@LastPageFooter\hfill%
        }
    }
    \def\@evenfoot{%     % 反面，仅对twoside文档生效
        \textcolor{gray}{%
            \footnotesize\@LastPageFooter\hfill%
        }
    }
}
\AtEndDocument{%         % 应用末页风格
    \thispagestyle{LastPage}%
}

% ============
% 四、定制模块
% ============

% 定制的个人信息标签
\newcommand\address[2][1]{%     % 地址
    \info[#1]{\faMapMarker}{#2}%
}
\newcommand\birthday[2][1]{%    % 生日
    \info[#1]{\faBirthdayCake}{#2}%
}
\newcommand\degree[2][1]{%      % 学位
    \info[#1]{\faGraduationCap}{#2}%
}
\newcommand\email[2][1]{%       % 邮箱
    \info[#1]{\faAt}%
    {\texttt{\href{mailto:#2}{#2}}}%
}
\newcommand\github[2][1]{%      % GitHub
    \info[#1]{\faGithub}%
    {\texttt{\href{https://github.com/#2}{#2}}}%
}
\newcommand\gitlab[2][1]{%      % Gitlab
    \info[#1]{\faGitlab}%
    {\texttt{\href{https://gitlab.com/#2}{#2}}}%
}
\newcommand\major[2][1]{%       % 专业
    \info[#1]{\faSearch}{#2}%
}
\newcommand\mobile[2][1]{%      % 手机
    \info[#1]{\faMobile*}{#2}%
}
\newcommand\department[2][1]{%  % 院系
    \info[#1]{\faBuilding}{#2}%
}
\newcommand\university[2][1]{%  % 学校
    \info[#1]{\faUniversity}{#2}%
}

% 定制的模块标题
\newcommand\moduleAca[1]{%   % 论文发表 Academic
    \module{#1}{\faFile*}%
}
\newcommand\moduleBk[1]{%    % 专著出版 Books
    \module{#1}{\faBook}%
}
\newcommand\moduleCfr[1]{%   % 学术会议 Conferences
    \module{#1}{\faComments}%
}
\newcommand\moduleCom[1]{%   % 技能特长 Competence
    \module{#1}{\faClipboardList}%
}
\newcommand\moduleEdu[1]{%   % 教育经历 Education
    \module{#1}{\faGraduationCap}%
}
\newcommand\moduleHob[1]{%   % 兴趣爱好 Hobbies
    \module{#1}{\faHeart}%
}
\newcommand\moduleIt[1]{%    % 信息科技 IT
    \module{#1}{\faCode}%
}
\newcommand\moduleRes[1]{%   % 科学研究 Research
    \module{#1}{\faAtom}%
}
\newcommand\moduleSta[1]{%   % 个人陈述 Statement
    \module{#1}{\faFeather*}%
}
\newcommand\moduleTit[1]{%   % 奖励荣誉 Titles
    \module{#1}{\faAward}%
}
\newcommand\moduleWrk[1]{%   % 实习工作 Works
    \module{#1}{\faBriefcase}%
}

% ============
% 五、其他设置
% ============

% 超链接设置
\RequirePackage[
    colorlinks,
    urlcolor    = Main,
    linkcolor   = Main,
    anchorcolor = Main,
    citecolor   = Main,
]{hyperref}
