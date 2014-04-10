; ModuleID = 'main.c'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, i8*, i8*, i8*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type { %struct._IO_marker*, %struct._IO_FILE*, i32 }
%struct.matcher = type { i8*, void (i8*, i64)*, i64 (i8*, i64, i64*, i8*)* }
%struct.exclude = type opaque
%struct.stats = type { %struct.stats*, %struct.stat }
%struct.stat = type { i64, i64, i64, i32, i32, i32, i32, i64, i64, i64, i64, %struct.timespec, %struct.timespec, %struct.timespec, [3 x i64] }
%struct.timespec = type { i64, i64 }
%struct.color_cap = type { i8*, i8**, i8* ()* }
%struct.option = type { i8*, i32, i32*, i32 }

@stderr = external global %struct._IO_FILE*
@.str = private unnamed_addr constant [41 x i8] c"Usage: %s [OPTION]... PATTERN [FILE]...\0A\00", align 1
@program_name = external global i8*
@.str1 = private unnamed_addr constant [39 x i8] c"Try `%s --help' for more information.\0A\00", align 1
@.str2 = private unnamed_addr constant [52 x i8] c"Search for PATTERN in each FILE or standard input.\0A\00", align 1
@.str3 = private unnamed_addr constant [3 x i8] c"%s\00", align 1
@before_options = external constant [0 x i8]
@.str4 = private unnamed_addr constant [82 x i8] c"Example: %s -i 'hello world' menu.h main.c\0A\0ARegexp selection and interpretation:\0A\00", align 1
@matchers = external constant [0 x %struct.matcher]
@.str5 = private unnamed_addr constant [294 x i8] c"  -E, --extended-regexp     PATTERN is an extended regular expression (ERE)\0A  -F, --fixed-strings       PATTERN is a set of newline-separated fixed strings\0A  -G, --basic-regexp        PATTERN is a basic regular expression (BRE)\0A  -P, --perl-regexp         PATTERN is a Perl regular expression\0A\00", align 1
@.str6 = private unnamed_addr constant [364 x i8] c"  -e, --regexp=PATTERN      use PATTERN for matching\0A  -f, --file=FILE           obtain PATTERN from FILE\0A  -i, --ignore-case         ignore case distinctions\0A  -w, --word-regexp         force PATTERN to match only whole words\0A  -x, --line-regexp         force PATTERN to match only whole lines\0A  -z, --null-data           a data line ends in 0 byte, not newline\0A\00", align 1
@.str7 = private unnamed_addr constant [305 x i8] c"\0AMiscellaneous:\0A  -s, --no-messages         suppress error messages\0A  -v, --invert-match        select non-matching lines\0A  -V, --version             print version information and exit\0A      --help                display this help and exit\0A      --mmap                ignored for backwards compatibility\0A\00", align 1
@.str8 = private unnamed_addr constant [459 x i8] c"\0AOutput control:\0A  -m, --max-count=NUM       stop after NUM matches\0A  -b, --byte-offset         print the byte offset with output lines\0A  -n, --line-number         print line number with output lines\0A      --line-buffered       flush output on every line\0A  -H, --with-filename       print the filename for each match\0A  -h, --no-filename         suppress the prefixing filename on output\0A      --label=LABEL         print LABEL as filename for standard input\0A\00", align 1
@.str9 = private unnamed_addr constant [328 x i8] c"  -o, --only-matching       show only the part of a line matching PATTERN\0A  -q, --quiet, --silent     suppress all normal output\0A      --binary-files=TYPE   assume that binary files are TYPE;\0A                            TYPE is `binary', `text', or `without-match'\0A  -a, --text                equivalent to --binary-files=text\0A\00", align 1
@.str10 = private unnamed_addr constant [383 x i8] c"  -I                        equivalent to --binary-files=without-match\0A  -d, --directories=ACTION  how to handle directories;\0A                            ACTION is `read', `recurse', or `skip'\0A  -D, --devices=ACTION      how to handle devices, FIFOs and sockets;\0A                            ACTION is `read' or `skip'\0A  -R, -r, --recursive       equivalent to --directories=recurse\0A\00", align 1
@.str11 = private unnamed_addr constant [304 x i8] c"      --include=FILE_PATTERN  search only files that match FILE_PATTERN\0A      --exclude=FILE_PATTERN  skip files and directories matching FILE_PATTERN\0A      --exclude-from=FILE   skip files matching any file pattern from FILE\0A      --exclude-dir=PATTERN  directories that match PATTERN will be skipped.\0A\00", align 1
@.str12 = private unnamed_addr constant [338 x i8] c"  -L, --files-without-match  print only names of FILEs containing no match\0A  -l, --files-with-matches  print only names of FILEs containing matches\0A  -c, --count               print only a count of matching lines per FILE\0A  -T, --initial-tab         make tabs line up (if needed)\0A  -Z, --null                print 0 byte after FILE name\0A\00", align 1
@.str13 = private unnamed_addr constant [208 x i8] c"\0AContext control:\0A  -B, --before-context=NUM  print NUM lines of leading context\0A  -A, --after-context=NUM   print NUM lines of trailing context\0A  -C, --context=NUM         print NUM lines of output context\0A\00", align 1
@.str14 = private unnamed_addr constant [360 x i8] c"  -NUM                      same as --context=NUM\0A      --color[=WHEN],\0A      --colour[=WHEN]       use markers to highlight the matching strings;\0A                            WHEN is `always', `never', or `auto'\0A  -U, --binary              do not strip CR characters at EOL (MSDOS)\0A  -u, --unix-byte-offsets   report offsets as if CRs were not there (MSDOS)\0A\0A\00", align 1
@after_options = external constant [0 x i8]
@.str15 = private unnamed_addr constant [222 x i8] c"With no FILE, or when FILE is -, read standard input.  If less than two FILEs\0Aare given, assume -h.  Exit status is 0 if any line was selected, 1 otherwise;\0Aif any error occurs and -q was not given, the exit status is 2.\0A\00", align 1
@.str16 = private unnamed_addr constant [21 x i8] c"\0AReport bugs to: %s\0A\00", align 1
@.str17 = private unnamed_addr constant [17 x i8] c"bug-grep@gnu.org\00", align 1
@.str18 = private unnamed_addr constant [26 x i8] c"GNU Grep home page: <%s>\0A\00", align 1
@.str19 = private unnamed_addr constant [34 x i8] c"http://www.gnu.org/software/grep/\00", align 1
@.str20 = private unnamed_addr constant [64 x i8] c"General help using GNU software: <http://www.gnu.org/gethelp/>\0A\00", align 1
@stdout = external global %struct._IO_FILE*
@eolbyte = common global i8 0, align 1
@filename_mask = internal unnamed_addr global i1 false
@max_count = internal unnamed_addr global i64 0, align 8
@out_before = internal global i32 0, align 4
@out_after = internal global i32 0, align 4
@only_matching = internal unnamed_addr global i1 false
@.str21 = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@.str22 = private unnamed_addr constant [5 x i8] c"grep\00", align 1
@.str23 = private unnamed_addr constant [24 x i8] c"/usr/local/share/locale\00", align 1
@exit_failure = external global i32
@.str24 = private unnamed_addr constant [13 x i8] c"GREP_OPTIONS\00", align 1
@optarg = external global i8*
@.str25 = private unnamed_addr constant [5 x i8] c"read\00", align 1
@devices = internal unnamed_addr global i1 false
@.str26 = private unnamed_addr constant [5 x i8] c"skip\00", align 1
@.str27 = private unnamed_addr constant [23 x i8] c"unknown devices method\00", align 1
@.str28 = private unnamed_addr constant [6 x i8] c"egrep\00", align 1
@.str29 = private unnamed_addr constant [6 x i8] c"fgrep\00", align 1
@.str30 = private unnamed_addr constant [5 x i8] c"perl\00", align 1
@no_filenames = internal unnamed_addr global i1 false
@binary_files = internal unnamed_addr global i32 0, align 4
@align_tabs = internal unnamed_addr global i1 false
@out_byte = internal unnamed_addr global i1 false
@count_matches = internal unnamed_addr global i1 false
@.str31 = private unnamed_addr constant [14 x i8] c"--directories\00", align 1
@directories_args = internal constant [4 x i8*] [i8* getelementptr inbounds ([5 x i8]* @.str25, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8]* @.str90, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8]* @.str26, i32 0, i32 0), i8* null], align 16
@directories_types = internal constant [3 x i32] [i32 2, i32 3, i32 4], align 4
@argmatch_die = external global void ()*
@directories = internal unnamed_addr global i32 2, align 4
@stdin = external global %struct._IO_FILE*
@.str33 = private unnamed_addr constant [2 x i8] c"r\00", align 1
@match_icase = common global i32 0, align 4
@list_files = internal unnamed_addr global i32 0, align 4
@.str34 = private unnamed_addr constant [18 x i8] c"invalid max count\00", align 1
@out_line = internal unnamed_addr global i1 false
@exit_on_match = internal unnamed_addr global i1 false
@suppress_errors = internal unnamed_addr global i1 false
@out_invert = internal unnamed_addr global i32 0, align 4
@match_words = common global i32 0, align 4
@match_lines = common global i32 0, align 4
@.str35 = private unnamed_addr constant [7 x i8] c"binary\00", align 1
@.str36 = private unnamed_addr constant [5 x i8] c"text\00", align 1
@.str37 = private unnamed_addr constant [14 x i8] c"without-match\00", align 1
@.str38 = private unnamed_addr constant [26 x i8] c"unknown binary-files type\00", align 1
@.str39 = private unnamed_addr constant [7 x i8] c"always\00", align 1
@.str40 = private unnamed_addr constant [4 x i8] c"yes\00", align 1
@.str41 = private unnamed_addr constant [6 x i8] c"force\00", align 1
@color_option = internal unnamed_addr global i32 0, align 4
@.str42 = private unnamed_addr constant [6 x i8] c"never\00", align 1
@.str43 = private unnamed_addr constant [3 x i8] c"no\00", align 1
@.str44 = private unnamed_addr constant [5 x i8] c"none\00", align 1
@.str45 = private unnamed_addr constant [5 x i8] c"auto\00", align 1
@.str46 = private unnamed_addr constant [4 x i8] c"tty\00", align 1
@.str47 = private unnamed_addr constant [7 x i8] c"if-tty\00", align 1
@show_help = internal global i32 0, align 4
@.str48 = private unnamed_addr constant [5 x i8] c"TERM\00", align 1
@.str49 = private unnamed_addr constant [5 x i8] c"dumb\00", align 1
@excluded_patterns = internal unnamed_addr global %struct.exclude* null, align 8
@excluded_directory_patterns = internal unnamed_addr global %struct.exclude* null, align 8
@included_patterns = internal unnamed_addr global %struct.exclude* null, align 8
@group_separator = internal unnamed_addr global i8* getelementptr inbounds ([3 x i8]* @.str89, i64 0, i64 0), align 8
@line_buffered = internal unnamed_addr global i1 false
@label = internal unnamed_addr global i8* null, align 8
@done_on_match = internal unnamed_addr global i32 0, align 4
@out_quiet = internal unnamed_addr global i32 0, align 4
@.str50 = private unnamed_addr constant [11 x i8] c"GREP_COLOR\00", align 1
@context_match_color = internal global i8* getelementptr inbounds ([6 x i8]* @.str88, i64 0, i64 0), align 8
@selected_match_color = internal global i8* getelementptr inbounds ([6 x i8]* @.str88, i64 0, i64 0), align 8
@.str51 = private unnamed_addr constant [9 x i8] c"GNU grep\00", align 1
@.str52 = private unnamed_addr constant [4 x i8] c"2.7\00", align 1
@.str53 = private unnamed_addr constant [13 x i8] c"Mike Haertel\00", align 1
@.str54 = private unnamed_addr constant [63 x i8] c"others, see <http://git.sv.gnu.org/cgit/grep.git/tree/AUTHORS>\00", align 1
@optind = external global i32
@compile = internal unnamed_addr global void (i8*, i64)* null, align 8
@out_file = internal unnamed_addr global i32 0, align 4
@stats_base = internal global %struct.stats zeroinitializer, align 8
@errseen = internal unnamed_addr global i1 false
@.str55 = private unnamed_addr constant [17 x i8] c"(standard input)\00", align 1
@filename = internal unnamed_addr global i8* null, align 8
@.str56 = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
@outleft = internal unnamed_addr global i64 0, align 8
@bufoffset = internal unnamed_addr global i64 0, align 8
@after_last_match = internal unnamed_addr global i64 0, align 8
@sep_color = internal global i8* getelementptr inbounds ([3 x i8]* @.str59, i64 0, i64 0), align 8
@sgr_start = internal unnamed_addr global i8* getelementptr inbounds ([9 x i8]* @.str58, i64 0, i64 0), align 8
@sgr_end = internal unnamed_addr global i8* getelementptr inbounds ([7 x i8]* @.str57, i64 0, i64 0), align 8
@.str57 = private unnamed_addr constant [7 x i8] c"\1B[m\1B[K\00", align 1
@.str58 = private unnamed_addr constant [9 x i8] c"\1B[%sm\1B[K\00", align 1
@.str59 = private unnamed_addr constant [3 x i8] c"36\00", align 1
@filename_color = internal global i8* getelementptr inbounds ([3 x i8]* @.str60, i64 0, i64 0), align 8
@.str60 = private unnamed_addr constant [3 x i8] c"35\00", align 1
@totalcc = internal unnamed_addr global i64 0, align 8
@lastout = internal unnamed_addr global i8* null, align 8
@totalnl = internal unnamed_addr global i64 0, align 8
@pending = internal unnamed_addr global i32 0, align 4
@bufbeg = internal unnamed_addr global i8* null, align 8
@buflim = internal unnamed_addr global i8* null, align 8
@lastnl = internal unnamed_addr global i8* null, align 8
@.str61 = private unnamed_addr constant [24 x i8] c"Binary file %s matches\0A\00", align 1
@.str62 = private unnamed_addr constant [28 x i8] c"input is too large to count\00", align 1
@execute = internal unnamed_addr global i64 (i8*, i64, i64*, i8*)* null, align 8
@selected_line_color = internal global i8* getelementptr inbounds ([1 x i8]* @.str21, i64 0, i64 0), align 8
@context_line_color = internal global i8* getelementptr inbounds ([1 x i8]* @.str21, i64 0, i64 0), align 8
@.str63 = private unnamed_addr constant [15 x i8] c"writing output\00", align 1
@.str64 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@line_num_color = internal global i8* getelementptr inbounds ([3 x i8]* @.str66, i64 0, i64 0), align 8
@byte_num_color = internal global i8* getelementptr inbounds ([3 x i8]* @.str66, i64 0, i64 0), align 8
@.str65 = private unnamed_addr constant [3 x i8] c"\09\08\00", align 1
@.str66 = private unnamed_addr constant [3 x i8] c"32\00", align 1
@prtext.used = internal unnamed_addr global i1 false
@buffer = internal unnamed_addr global i8* null, align 8
@pagesize = internal unnamed_addr global i64 0, align 8
@bufalloc = internal unnamed_addr global i64 0, align 8
@bufdesc = internal unnamed_addr global i32 0, align 4
@.str67 = private unnamed_addr constant [13 x i8] c"lseek failed\00", align 1
@.str68 = private unnamed_addr constant [16 x i8] c"warning: %s: %s\00", align 1
@.str69 = private unnamed_addr constant [25 x i8] c"recursive directory loop\00", align 1
@.str70 = private unnamed_addr constant [12 x i8] c"GREP_COLORS\00", align 1
@color_dict = internal unnamed_addr constant [12 x %struct.color_cap] [%struct.color_cap { i8* getelementptr inbounds ([3 x i8]* @.str75, i32 0, i32 0), i8** @selected_match_color, i8* ()* @color_cap_mt_fct }, %struct.color_cap { i8* getelementptr inbounds ([3 x i8]* @.str76, i32 0, i32 0), i8** @selected_match_color, i8* ()* null }, %struct.color_cap { i8* getelementptr inbounds ([3 x i8]* @.str77, i32 0, i32 0), i8** @context_match_color, i8* ()* null }, %struct.color_cap { i8* getelementptr inbounds ([3 x i8]* @.str78, i32 0, i32 0), i8** @filename_color, i8* ()* null }, %struct.color_cap { i8* getelementptr inbounds ([3 x i8]* @.str79, i32 0, i32 0), i8** @line_num_color, i8* ()* null }, %struct.color_cap { i8* getelementptr inbounds ([3 x i8]* @.str80, i32 0, i32 0), i8** @byte_num_color, i8* ()* null }, %struct.color_cap { i8* getelementptr inbounds ([3 x i8]* @.str81, i32 0, i32 0), i8** @sep_color, i8* ()* null }, %struct.color_cap { i8* getelementptr inbounds ([3 x i8]* @.str82, i32 0, i32 0), i8** @selected_line_color, i8* ()* null }, %struct.color_cap { i8* getelementptr inbounds ([3 x i8]* @.str83, i32 0, i32 0), i8** @context_line_color, i8* ()* null }, %struct.color_cap { i8* getelementptr inbounds ([3 x i8]* @.str84, i32 0, i32 0), i8** null, i8* ()* @color_cap_rv_fct }, %struct.color_cap { i8* getelementptr inbounds ([3 x i8]* @.str85, i32 0, i32 0), i8** null, i8* ()* @color_cap_ne_fct }, %struct.color_cap zeroinitializer], align 16
@.str71 = private unnamed_addr constant [71 x i8] c"in GREP_COLORS=\22%s\22, the \22%s\22 capacity needs a value (\22=...\22); skipped\00", align 1
@.str72 = private unnamed_addr constant [91 x i8] c"in GREP_COLORS=\22%s\22, the \22%s\22 capacity is boolean and cannot take a value (\22=%s\22); skipped\00", align 1
@.str73 = private unnamed_addr constant [42 x i8] c"in GREP_COLORS=\22%s\22, the \22%s\22 capacity %s\00", align 1
@.str74 = private unnamed_addr constant [78 x i8] c"stopped processing of ill-formed GREP_COLORS=\22%s\22 at remaining substring \22%s\22\00", align 1
@.str75 = private unnamed_addr constant [3 x i8] c"mt\00", align 1
@.str76 = private unnamed_addr constant [3 x i8] c"ms\00", align 1
@.str77 = private unnamed_addr constant [3 x i8] c"mc\00", align 1
@.str78 = private unnamed_addr constant [3 x i8] c"fn\00", align 1
@.str79 = private unnamed_addr constant [3 x i8] c"ln\00", align 1
@.str80 = private unnamed_addr constant [3 x i8] c"bn\00", align 1
@.str81 = private unnamed_addr constant [3 x i8] c"se\00", align 1
@.str82 = private unnamed_addr constant [3 x i8] c"sl\00", align 1
@.str83 = private unnamed_addr constant [3 x i8] c"cx\00", align 1
@.str84 = private unnamed_addr constant [3 x i8] c"rv\00", align 1
@.str85 = private unnamed_addr constant [3 x i8] c"ne\00", align 1
@.str86 = private unnamed_addr constant [6 x i8] c"\1B[%sm\00", align 1
@.str87 = private unnamed_addr constant [4 x i8] c"\1B[m\00", align 1
@.str88 = private unnamed_addr constant [6 x i8] c"01;31\00", align 1
@.str89 = private unnamed_addr constant [3 x i8] c"--\00", align 1
@.str90 = private unnamed_addr constant [8 x i8] c"recurse\00", align 1
@.str91 = private unnamed_addr constant [7 x i8] c"%s: %s\00", align 1
@.str92 = private unnamed_addr constant [32 x i8] c"invalid context length argument\00", align 1
@get_nondigit_option.prev_digit_optind = internal unnamed_addr global i32 -1, align 4
@short_options = internal constant [59 x i8] c"0123456789A:B:C:D:EFGHIPTUVX:abcd:e:f:hiKLlm:noqRrsuvwxyZz\00", align 16
@.str94 = private unnamed_addr constant [13 x i8] c"basic-regexp\00", align 1
@.str95 = private unnamed_addr constant [16 x i8] c"extended-regexp\00", align 1
@.str96 = private unnamed_addr constant [13 x i8] c"fixed-regexp\00", align 1
@.str97 = private unnamed_addr constant [14 x i8] c"fixed-strings\00", align 1
@.str98 = private unnamed_addr constant [12 x i8] c"perl-regexp\00", align 1
@.str99 = private unnamed_addr constant [14 x i8] c"after-context\00", align 1
@.str100 = private unnamed_addr constant [15 x i8] c"before-context\00", align 1
@.str101 = private unnamed_addr constant [13 x i8] c"binary-files\00", align 1
@.str102 = private unnamed_addr constant [12 x i8] c"byte-offset\00", align 1
@.str103 = private unnamed_addr constant [8 x i8] c"context\00", align 1
@.str104 = private unnamed_addr constant [6 x i8] c"color\00", align 1
@.str105 = private unnamed_addr constant [7 x i8] c"colour\00", align 1
@.str106 = private unnamed_addr constant [6 x i8] c"count\00", align 1
@.str107 = private unnamed_addr constant [8 x i8] c"devices\00", align 1
@.str108 = private unnamed_addr constant [12 x i8] c"directories\00", align 1
@.str109 = private unnamed_addr constant [8 x i8] c"exclude\00", align 1
@.str110 = private unnamed_addr constant [13 x i8] c"exclude-from\00", align 1
@.str111 = private unnamed_addr constant [12 x i8] c"exclude-dir\00", align 1
@.str112 = private unnamed_addr constant [5 x i8] c"file\00", align 1
@.str113 = private unnamed_addr constant [19 x i8] c"files-with-matches\00", align 1
@.str114 = private unnamed_addr constant [20 x i8] c"files-without-match\00", align 1
@.str115 = private unnamed_addr constant [16 x i8] c"group-separator\00", align 1
@.str116 = private unnamed_addr constant [5 x i8] c"help\00", align 1
@.str117 = private unnamed_addr constant [8 x i8] c"include\00", align 1
@.str118 = private unnamed_addr constant [12 x i8] c"ignore-case\00", align 1
@.str119 = private unnamed_addr constant [12 x i8] c"initial-tab\00", align 1
@.str120 = private unnamed_addr constant [6 x i8] c"label\00", align 1
@.str121 = private unnamed_addr constant [14 x i8] c"line-buffered\00", align 1
@.str122 = private unnamed_addr constant [12 x i8] c"line-number\00", align 1
@.str123 = private unnamed_addr constant [12 x i8] c"line-regexp\00", align 1
@.str124 = private unnamed_addr constant [10 x i8] c"max-count\00", align 1
@.str125 = private unnamed_addr constant [5 x i8] c"mmap\00", align 1
@.str126 = private unnamed_addr constant [12 x i8] c"no-filename\00", align 1
@.str127 = private unnamed_addr constant [19 x i8] c"no-group-separator\00", align 1
@.str128 = private unnamed_addr constant [12 x i8] c"no-messages\00", align 1
@.str129 = private unnamed_addr constant [5 x i8] c"null\00", align 1
@.str130 = private unnamed_addr constant [10 x i8] c"null-data\00", align 1
@.str131 = private unnamed_addr constant [14 x i8] c"only-matching\00", align 1
@.str132 = private unnamed_addr constant [6 x i8] c"quiet\00", align 1
@.str133 = private unnamed_addr constant [10 x i8] c"recursive\00", align 1
@.str134 = private unnamed_addr constant [7 x i8] c"regexp\00", align 1
@.str135 = private unnamed_addr constant [13 x i8] c"invert-match\00", align 1
@.str136 = private unnamed_addr constant [7 x i8] c"silent\00", align 1
@.str137 = private unnamed_addr constant [18 x i8] c"unix-byte-offsets\00", align 1
@.str138 = private unnamed_addr constant [8 x i8] c"version\00", align 1
@.str139 = private unnamed_addr constant [14 x i8] c"with-filename\00", align 1
@.str140 = private unnamed_addr constant [12 x i8] c"word-regexp\00", align 1
@long_options = internal constant <{ { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] } }> <{ { i8*, i32, i32*, i32, [4 x i8] } { i8* getelementptr inbounds ([13 x i8]* @.str94, i32 0, i32 0), i32 0, i32* null, i32 71, [4 x i8] undef }, { i8*, i32, i32*, i32, [4 x i8] } { i8* getelementptr inbounds ([16 x i8]* @.str95, i32 0, i32 0), i32 0, i32* null, i32 69, [4 x i8] undef }, { i8*, i32, i32*, i32, [4 x i8] } { i8* getelementptr inbounds ([13 x i8]* @.str96, i32 0, i32 0), i32 0, i32* null, i32 70, [4 x i8] undef }, { i8*, i32, i32*, i32, [4 x i8] } { i8* getelementptr inbounds ([14 x i8]* @.str97, i32 0, i32 0), i32 0, i32* null, i32 70, [4 x i8] undef }, { i8*, i32, i32*, i32, [4 x i8] } { i8* getelementptr inbounds ([12 x i8]* @.str98, i32 0, i32 0), i32 0, i32* null, i32 80, [4 x i8] undef }, { i8*, i32, i32*, i32, [4 x i8] } { i8* getelementptr inbounds ([14 x i8]* @.str99, i32 0, i32 0), i32 1, i32* null, i32 65, [4 x i8] undef }, { i8*, i32, i32*, i32, [4 x i8] } { i8* getelementptr inbounds ([15 x i8]* @.str100, i32 0, i32 0), i32 1, i32* null, i32 66, [4 x i8] undef }, { i8*, i32, i32*, i32, [4 x i8] } { i8* getelementptr inbounds ([13 x i8]* @.str101, i32 0, i32 0), i32 1, i32* null, i32 128, [4 x i8] undef }, { i8*, i32, i32*, i32, [4 x i8] } { i8* getelementptr inbounds ([12 x i8]* @.str102, i32 0, i32 0), i32 0, i32* null, i32 98, [4 x i8] undef }, { i8*, i32, i32*, i32, [4 x i8] } { i8* getelementptr inbounds ([8 x i8]* @.str103, i32 0, i32 0), i32 1, i32* null, i32 67, [4 x i8] undef }, { i8*, i32, i32*, i32, [4 x i8] } { i8* getelementptr inbounds ([6 x i8]* @.str104, i32 0, i32 0), i32 2, i32* null, i32 129, [4 x i8] undef }, { i8*, i32, i32*, i32, [4 x i8] } { i8* getelementptr inbounds ([7 x i8]* @.str105, i32 0, i32 0), i32 2, i32* null, i32 129, [4 x i8] undef }, { i8*, i32, i32*, i32, [4 x i8] } { i8* getelementptr inbounds ([6 x i8]* @.str106, i32 0, i32 0), i32 0, i32* null, i32 99, [4 x i8] undef }, { i8*, i32, i32*, i32, [4 x i8] } { i8* getelementptr inbounds ([8 x i8]* @.str107, i32 0, i32 0), i32 1, i32* null, i32 68, [4 x i8] undef }, { i8*, i32, i32*, i32, [4 x i8] } { i8* getelementptr inbounds ([12 x i8]* @.str108, i32 0, i32 0), i32 1, i32* null, i32 100, [4 x i8] undef }, { i8*, i32, i32*, i32, [4 x i8] } { i8* getelementptr inbounds ([8 x i8]* @.str109, i32 0, i32 0), i32 1, i32* null, i32 131, [4 x i8] undef }, { i8*, i32, i32*, i32, [4 x i8] } { i8* getelementptr inbounds ([13 x i8]* @.str110, i32 0, i32 0), i32 1, i32* null, i32 132, [4 x i8] undef }, { i8*, i32, i32*, i32, [4 x i8] } { i8* getelementptr inbounds ([12 x i8]* @.str111, i32 0, i32 0), i32 1, i32* null, i32 135, [4 x i8] undef }, { i8*, i32, i32*, i32, [4 x i8] } { i8* getelementptr inbounds ([5 x i8]* @.str112, i32 0, i32 0), i32 1, i32* null, i32 102, [4 x i8] undef }, { i8*, i32, i32*, i32, [4 x i8] } { i8* getelementptr inbounds ([19 x i8]* @.str113, i32 0, i32 0), i32 0, i32* null, i32 108, [4 x i8] undef }, { i8*, i32, i32*, i32, [4 x i8] } { i8* getelementptr inbounds ([20 x i8]* @.str114, i32 0, i32 0), i32 0, i32* null, i32 76, [4 x i8] undef }, { i8*, i32, i32*, i32, [4 x i8] } { i8* getelementptr inbounds ([16 x i8]* @.str115, i32 0, i32 0), i32 1, i32* null, i32 136, [4 x i8] undef }, { i8*, i32, i32*, i32, [4 x i8] } { i8* getelementptr inbounds ([5 x i8]* @.str116, i32 0, i32 0), i32 0, i32* @show_help, i32 1, [4 x i8] undef }, { i8*, i32, i32*, i32, [4 x i8] } { i8* getelementptr inbounds ([8 x i8]* @.str117, i32 0, i32 0), i32 1, i32* null, i32 130, [4 x i8] undef }, { i8*, i32, i32*, i32, [4 x i8] } { i8* getelementptr inbounds ([12 x i8]* @.str118, i32 0, i32 0), i32 0, i32* null, i32 105, [4 x i8] undef }, { i8*, i32, i32*, i32, [4 x i8] } { i8* getelementptr inbounds ([12 x i8]* @.str119, i32 0, i32 0), i32 0, i32* null, i32 84, [4 x i8] undef }, { i8*, i32, i32*, i32, [4 x i8] } { i8* getelementptr inbounds ([6 x i8]* @.str120, i32 0, i32 0), i32 1, i32* null, i32 134, [4 x i8] undef }, { i8*, i32, i32*, i32, [4 x i8] } { i8* getelementptr inbounds ([14 x i8]* @.str121, i32 0, i32 0), i32 0, i32* null, i32 133, [4 x i8] undef }, { i8*, i32, i32*, i32, [4 x i8] } { i8* getelementptr inbounds ([12 x i8]* @.str122, i32 0, i32 0), i32 0, i32* null, i32 110, [4 x i8] undef }, { i8*, i32, i32*, i32, [4 x i8] } { i8* getelementptr inbounds ([12 x i8]* @.str123, i32 0, i32 0), i32 0, i32* null, i32 120, [4 x i8] undef }, { i8*, i32, i32*, i32, [4 x i8] } { i8* getelementptr inbounds ([10 x i8]* @.str124, i32 0, i32 0), i32 1, i32* null, i32 109, [4 x i8] undef }, { i8*, i32, i32*, i32, [4 x i8] } { i8* getelementptr inbounds ([5 x i8]* @.str125, i32 0, i32 0), i32 0, i32* null, i32 137, [4 x i8] undef }, { i8*, i32, i32*, i32, [4 x i8] } { i8* getelementptr inbounds ([12 x i8]* @.str126, i32 0, i32 0), i32 0, i32* null, i32 104, [4 x i8] undef }, { i8*, i32, i32*, i32, [4 x i8] } { i8* getelementptr inbounds ([19 x i8]* @.str127, i32 0, i32 0), i32 0, i32* null, i32 136, [4 x i8] undef }, { i8*, i32, i32*, i32, [4 x i8] } { i8* getelementptr inbounds ([12 x i8]* @.str128, i32 0, i32 0), i32 0, i32* null, i32 115, [4 x i8] undef }, { i8*, i32, i32*, i32, [4 x i8] } { i8* getelementptr inbounds ([5 x i8]* @.str129, i32 0, i32 0), i32 0, i32* null, i32 90, [4 x i8] undef }, { i8*, i32, i32*, i32, [4 x i8] } { i8* getelementptr inbounds ([10 x i8]* @.str130, i32 0, i32 0), i32 0, i32* null, i32 122, [4 x i8] undef }, { i8*, i32, i32*, i32, [4 x i8] } { i8* getelementptr inbounds ([14 x i8]* @.str131, i32 0, i32 0), i32 0, i32* null, i32 111, [4 x i8] undef }, { i8*, i32, i32*, i32, [4 x i8] } { i8* getelementptr inbounds ([6 x i8]* @.str132, i32 0, i32 0), i32 0, i32* null, i32 113, [4 x i8] undef }, { i8*, i32, i32*, i32, [4 x i8] } { i8* getelementptr inbounds ([10 x i8]* @.str133, i32 0, i32 0), i32 0, i32* null, i32 114, [4 x i8] undef }, { i8*, i32, i32*, i32, [4 x i8] } { i8* getelementptr inbounds ([10 x i8]* @.str133, i32 0, i32 0), i32 0, i32* null, i32 82, [4 x i8] undef }, { i8*, i32, i32*, i32, [4 x i8] } { i8* getelementptr inbounds ([7 x i8]* @.str134, i32 0, i32 0), i32 1, i32* null, i32 101, [4 x i8] undef }, { i8*, i32, i32*, i32, [4 x i8] } { i8* getelementptr inbounds ([13 x i8]* @.str135, i32 0, i32 0), i32 0, i32* null, i32 118, [4 x i8] undef }, { i8*, i32, i32*, i32, [4 x i8] } { i8* getelementptr inbounds ([7 x i8]* @.str136, i32 0, i32 0), i32 0, i32* null, i32 113, [4 x i8] undef }, { i8*, i32, i32*, i32, [4 x i8] } { i8* getelementptr inbounds ([5 x i8]* @.str36, i32 0, i32 0), i32 0, i32* null, i32 97, [4 x i8] undef }, { i8*, i32, i32*, i32, [4 x i8] } { i8* getelementptr inbounds ([7 x i8]* @.str35, i32 0, i32 0), i32 0, i32* null, i32 85, [4 x i8] undef }, { i8*, i32, i32*, i32, [4 x i8] } { i8* getelementptr inbounds ([18 x i8]* @.str137, i32 0, i32 0), i32 0, i32* null, i32 117, [4 x i8] undef }, { i8*, i32, i32*, i32, [4 x i8] } { i8* getelementptr inbounds ([8 x i8]* @.str138, i32 0, i32 0), i32 0, i32* null, i32 86, [4 x i8] undef }, { i8*, i32, i32*, i32, [4 x i8] } { i8* getelementptr inbounds ([14 x i8]* @.str139, i32 0, i32 0), i32 0, i32* null, i32 72, [4 x i8] undef }, { i8*, i32, i32*, i32, [4 x i8] } { i8* getelementptr inbounds ([12 x i8]* @.str140, i32 0, i32 0), i32 0, i32* null, i32 119, [4 x i8] undef }, { i8*, i32, i32*, i32, [4 x i8] } { i8* null, i32 0, i32* null, i32 0, [4 x i8] undef } }>, align 16
@setmatcher.matcher = internal unnamed_addr global i8* null, align 8
@.str141 = private unnamed_addr constant [38 x i8] c"%s can only use the %s pattern syntax\00", align 1
@.str142 = private unnamed_addr constant [31 x i8] c"conflicting matchers specified\00", align 1
@.str143 = private unnamed_addr constant [19 x i8] c"invalid matcher %s\00", align 1

; Function Attrs: noreturn nounwind uwtable
define void @usage(i32 %status) #0 {
  tail call void @llvm.dbg.value(metadata !{i32 %status}, i64 0, metadata !53), !dbg !712
  %1 = icmp eq i32 %status, 0, !dbg !713
  br i1 %1, label %11, label %2, !dbg !713

; <label>:2                                       ; preds = %0
  %3 = load %struct._IO_FILE** @stderr, align 8, !dbg !715, !tbaa !717
  %4 = tail call i8* @dcgettext(i8* null, i8* getelementptr inbounds ([41 x i8]* @.str, i64 0, i64 0), i32 5) #8, !dbg !715
  %5 = load i8** @program_name, align 8, !dbg !715, !tbaa !717
  %6 = tail call i32 (%struct._IO_FILE*, i8*, ...)* @fprintf(%struct._IO_FILE* %3, i8* %4, i8* %5) #10, !dbg !715
  %7 = load %struct._IO_FILE** @stderr, align 8, !dbg !721, !tbaa !717
  %8 = tail call i8* @dcgettext(i8* null, i8* getelementptr inbounds ([39 x i8]* @.str1, i64 0, i64 0), i32 5) #8, !dbg !721
  %9 = load i8** @program_name, align 8, !dbg !721, !tbaa !717
  %10 = tail call i32 (%struct._IO_FILE*, i8*, ...)* @fprintf(%struct._IO_FILE* %7, i8* %8, i8* %9) #10, !dbg !721
  br label %57, !dbg !722

; <label>:11                                      ; preds = %0
  %12 = tail call i8* @dcgettext(i8* null, i8* getelementptr inbounds ([41 x i8]* @.str, i64 0, i64 0), i32 5) #8, !dbg !723
  %13 = load i8** @program_name, align 8, !dbg !723, !tbaa !717
  %14 = tail call i32 (i8*, ...)* @printf(i8* %12, i8* %13) #8, !dbg !723
  %15 = tail call i8* @dcgettext(i8* null, i8* getelementptr inbounds ([52 x i8]* @.str2, i64 0, i64 0), i32 5) #8, !dbg !725
  %16 = tail call i32 (i8*, ...)* @printf(i8* %15) #8, !dbg !725
  %17 = tail call i8* @dcgettext(i8* null, i8* getelementptr inbounds ([0 x i8]* @before_options, i64 0, i64 0), i32 5) #8, !dbg !726
  %18 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([3 x i8]* @.str3, i64 0, i64 0), i8* %17) #8, !dbg !726
  %19 = tail call i8* @dcgettext(i8* null, i8* getelementptr inbounds ([82 x i8]* @.str4, i64 0, i64 0), i32 5) #8, !dbg !727
  %20 = load i8** @program_name, align 8, !dbg !727, !tbaa !717
  %21 = tail call i32 (i8*, ...)* @printf(i8* %19, i8* %20) #8, !dbg !727
  %22 = load i8** getelementptr inbounds ([0 x %struct.matcher]* @matchers, i64 0, i64 1, i32 0), align 8, !dbg !728, !tbaa !730
  %23 = icmp eq i8* %22, null, !dbg !728
  br i1 %23, label %27, label %24, !dbg !728

; <label>:24                                      ; preds = %11
  %25 = tail call i8* @dcgettext(i8* null, i8* getelementptr inbounds ([294 x i8]* @.str5, i64 0, i64 0), i32 5) #8, !dbg !732
  %26 = tail call i32 (i8*, ...)* @printf(i8* %25) #8, !dbg !732
  br label %27, !dbg !732

; <label>:27                                      ; preds = %11, %24
  %28 = tail call i8* @dcgettext(i8* null, i8* getelementptr inbounds ([364 x i8]* @.str6, i64 0, i64 0), i32 5) #8, !dbg !733
  %29 = tail call i32 (i8*, ...)* @printf(i8* %28) #8, !dbg !733
  %30 = tail call i8* @dcgettext(i8* null, i8* getelementptr inbounds ([305 x i8]* @.str7, i64 0, i64 0), i32 5) #8, !dbg !734
  %31 = tail call i32 (i8*, ...)* @printf(i8* %30) #8, !dbg !734
  %32 = tail call i8* @dcgettext(i8* null, i8* getelementptr inbounds ([459 x i8]* @.str8, i64 0, i64 0), i32 5) #8, !dbg !735
  %33 = tail call i32 (i8*, ...)* @printf(i8* %32) #8, !dbg !735
  %34 = tail call i8* @dcgettext(i8* null, i8* getelementptr inbounds ([328 x i8]* @.str9, i64 0, i64 0), i32 5) #8, !dbg !736
  %35 = tail call i32 (i8*, ...)* @printf(i8* %34) #8, !dbg !736
  %36 = tail call i8* @dcgettext(i8* null, i8* getelementptr inbounds ([383 x i8]* @.str10, i64 0, i64 0), i32 5) #8, !dbg !737
  %37 = tail call i32 (i8*, ...)* @printf(i8* %36) #8, !dbg !737
  %38 = tail call i8* @dcgettext(i8* null, i8* getelementptr inbounds ([304 x i8]* @.str11, i64 0, i64 0), i32 5) #8, !dbg !738
  %39 = tail call i32 (i8*, ...)* @printf(i8* %38) #8, !dbg !738
  %40 = tail call i8* @dcgettext(i8* null, i8* getelementptr inbounds ([338 x i8]* @.str12, i64 0, i64 0), i32 5) #8, !dbg !739
  %41 = tail call i32 (i8*, ...)* @printf(i8* %40) #8, !dbg !739
  %42 = tail call i8* @dcgettext(i8* null, i8* getelementptr inbounds ([208 x i8]* @.str13, i64 0, i64 0), i32 5) #8, !dbg !740
  %43 = tail call i32 (i8*, ...)* @printf(i8* %42) #8, !dbg !740
  %44 = tail call i8* @dcgettext(i8* null, i8* getelementptr inbounds ([360 x i8]* @.str14, i64 0, i64 0), i32 5) #8, !dbg !741
  %45 = tail call i32 (i8*, ...)* @printf(i8* %44) #8, !dbg !741
  %46 = tail call i8* @dcgettext(i8* null, i8* getelementptr inbounds ([0 x i8]* @after_options, i64 0, i64 0), i32 5) #8, !dbg !742
  %47 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([3 x i8]* @.str3, i64 0, i64 0), i8* %46) #8, !dbg !742
  %48 = tail call i8* @dcgettext(i8* null, i8* getelementptr inbounds ([222 x i8]* @.str15, i64 0, i64 0), i32 5) #8, !dbg !743
  %49 = tail call i32 (i8*, ...)* @printf(i8* %48) #8, !dbg !743
  %50 = tail call i8* @dcgettext(i8* null, i8* getelementptr inbounds ([21 x i8]* @.str16, i64 0, i64 0), i32 5) #8, !dbg !744
  %51 = tail call i32 (i8*, ...)* @printf(i8* %50, i8* getelementptr inbounds ([17 x i8]* @.str17, i64 0, i64 0)) #8, !dbg !744
  %52 = tail call i8* @dcgettext(i8* null, i8* getelementptr inbounds ([26 x i8]* @.str18, i64 0, i64 0), i32 5) #8, !dbg !745
  %53 = tail call i32 (i8*, ...)* @printf(i8* %52, i8* getelementptr inbounds ([34 x i8]* @.str19, i64 0, i64 0)) #8, !dbg !745
  %54 = tail call i8* @dcgettext(i8* null, i8* getelementptr inbounds ([64 x i8]* @.str20, i64 0, i64 0), i32 5) #8, !dbg !746
  %55 = load %struct._IO_FILE** @stdout, align 8, !dbg !746, !tbaa !717
  %56 = tail call i32 @fputs_unlocked(i8* %54, %struct._IO_FILE* %55) #8, !dbg !746
  br label %57

; <label>:57                                      ; preds = %27, %2
  tail call void @exit(i32 %status) #11, !dbg !747
  unreachable, !dbg !747
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata) #1

; Function Attrs: nounwind
declare i32 @fprintf(%struct._IO_FILE* nocapture, i8* nocapture readonly, ...) #2

; Function Attrs: nounwind
declare i8* @dcgettext(i8*, i8*, i32) #2

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #2

declare i32 @fputs_unlocked(i8*, %struct._IO_FILE*) #3

; Function Attrs: noreturn nounwind
declare void @exit(i32) #4

; Function Attrs: noreturn nounwind uwtable
define i32 @main(i32 %argc, i8** %argv) #0 {
  %value.i92 = alloca i64, align 8
  %value.i89 = alloca i64, align 8
  %value.i = alloca i64, align 8
  %value.i.i = alloca i64, align 8
  %buf.i = alloca [68 x i8], align 16
  %value = alloca i64, align 8
  call void @llvm.dbg.value(metadata !{i32 %argc}, i64 0, metadata !61), !dbg !748
  call void @llvm.dbg.value(metadata !{i32 %argc}, i64 0, metadata !749), !dbg !751
  call void @llvm.dbg.value(metadata !{i32 %argc}, i64 0, metadata !61), !dbg !752
  call void @llvm.dbg.value(metadata !{i32 %argc}, i64 0, metadata !61), !dbg !753
  call void @llvm.dbg.value(metadata !{i32 %argc}, i64 0, metadata !61), !dbg !756
  call void @llvm.dbg.value(metadata !{i32 %argc}, i64 0, metadata !61), !dbg !758
  call void @llvm.dbg.value(metadata !{i32 %argc}, i64 0, metadata !61), !dbg !759
  call void @llvm.dbg.value(metadata !{i8** %argv}, i64 0, metadata !62), !dbg !748
  call void @llvm.dbg.value(metadata !{i8** %argv}, i64 0, metadata !760), !dbg !751
  call void @llvm.dbg.value(metadata !{i8** %argv}, i64 0, metadata !62), !dbg !761
  call void @llvm.dbg.value(metadata !{i8** %argv}, i64 0, metadata !62), !dbg !752
  call void @llvm.dbg.value(metadata !{i8** %argv}, i64 0, metadata !62), !dbg !762
  call void @llvm.dbg.value(metadata !{i8** %argv}, i64 0, metadata !62), !dbg !764
  call void @llvm.dbg.value(metadata !{i8** %argv}, i64 0, metadata !62), !dbg !765
  %1 = load i8** %argv, align 8, !dbg !766, !tbaa !717
  call void @set_program_name(i8* %1) #8, !dbg !766
  %2 = load i8** %argv, align 8, !dbg !761, !tbaa !717
  store i8* %2, i8** @program_name, align 8, !dbg !761, !tbaa !717
  call void @llvm.dbg.value(metadata !767, i64 0, metadata !63), !dbg !768
  call void @llvm.dbg.value(metadata !769, i64 0, metadata !64), !dbg !770
  call void @llvm.dbg.value(metadata !45, i64 0, metadata !70), !dbg !771
  store i8 10, i8* @eolbyte, align 1, !dbg !772, !tbaa !773
  store i1 true, i1* @filename_mask, align 1
  store i64 9223372036854775807, i64* @max_count, align 8, !dbg !774, !tbaa !775
  store i32 -1, i32* @out_before, align 4, !dbg !777, !tbaa !778
  store i32 -1, i32* @out_after, align 4, !dbg !777, !tbaa !778
  call void @llvm.dbg.value(metadata !45, i64 0, metadata !74), !dbg !780
  call void @llvm.dbg.value(metadata !45, i64 0, metadata !781), !dbg !783
  call void @llvm.dbg.value(metadata !45, i64 0, metadata !784), !dbg !788
  call void @llvm.dbg.value(metadata !45, i64 0, metadata !789), !dbg !790
  call void @llvm.dbg.value(metadata !45, i64 0, metadata !74), !dbg !791
  call void @llvm.dbg.value(metadata !45, i64 0, metadata !74), !dbg !793
  store i1 false, i1* @only_matching, align 1
  %3 = call i8* @setlocale(i32 6, i8* getelementptr inbounds ([1 x i8]* @.str21, i64 0, i64 0)) #8, !dbg !795
  %4 = call i8* @bindtextdomain(i8* getelementptr inbounds ([5 x i8]* @.str22, i64 0, i64 0), i8* getelementptr inbounds ([24 x i8]* @.str23, i64 0, i64 0)) #8, !dbg !796
  %5 = call i8* @textdomain(i8* getelementptr inbounds ([5 x i8]* @.str22, i64 0, i64 0)) #8, !dbg !797
  store volatile i32 2, i32* @exit_failure, align 4, !dbg !798, !tbaa !778
  %6 = call i32 @atexit(void ()* @close_stdout) #8, !dbg !799
  %7 = call i8* @getenv(i8* getelementptr inbounds ([13 x i8]* @.str24, i64 0, i64 0)) #8, !dbg !750
  call void @llvm.dbg.value(metadata !{i8* %7}, i64 0, metadata !800) #8, !dbg !751
  %8 = icmp eq i8* %7, null, !dbg !801
  br i1 %8, label %prepend_default_options.exit, label %9, !dbg !801

; <label>:9                                       ; preds = %0
  %10 = load i8* %7, align 1, !dbg !801, !tbaa !773
  %11 = icmp eq i8 %10, 0, !dbg !801
  br i1 %11, label %prepend_default_options.exit, label %12, !dbg !801

; <label>:12                                      ; preds = %9
  %13 = call i64 @strlen(i8* %7) #12, !dbg !802
  %14 = add i64 %13, 1, !dbg !802
  %15 = call noalias i8* @xmalloc(i64 %14) #8, !dbg !802
  call void @llvm.dbg.value(metadata !{i8* %15}, i64 0, metadata !803) #8, !dbg !802
  call void @llvm.dbg.value(metadata !{i8* %7}, i64 0, metadata !804) #8, !dbg !806
  call void @llvm.dbg.value(metadata !{i8* %15}, i64 0, metadata !807) #8, !dbg !806
  call void @llvm.dbg.value(metadata !808, i64 0, metadata !809) #8, !dbg !806
  call void @llvm.dbg.value(metadata !{i8* %7}, i64 0, metadata !810) #8, !dbg !811
  call void @llvm.dbg.value(metadata !{i8* %15}, i64 0, metadata !812) #8, !dbg !813
  call void @llvm.dbg.value(metadata !45, i64 0, metadata !814) #8, !dbg !815
  br label %.outer.i.i, !dbg !816

.outer.i.i:                                       ; preds = %.critedge.i.i, %12
  %indvars.iv.i.i = phi i64 [ %indvars.iv.next.i.i, %.critedge.i.i ], [ 0, %12 ]
  %b.0.ph.i.i = phi i8* [ %31, %.critedge.i.i ], [ %15, %12 ]
  %o.0.ph.i.i = phi i8* [ %o.2.i.i, %.critedge.i.i ], [ %7, %12 ]
  br label %16

; <label>:16                                      ; preds = %switch.edge.i.i, %.outer.i.i
  %o.0.i.i = phi i8* [ %18, %switch.edge.i.i ], [ %o.0.ph.i.i, %.outer.i.i ]
  %17 = load i8* %o.0.i.i, align 1, !dbg !817, !tbaa !773
  switch i8 %17, label %19 [
    i8 32, label %switch.edge.i.i
    i8 12, label %switch.edge.i.i
    i8 11, label %switch.edge.i.i
    i8 10, label %switch.edge.i.i
    i8 9, label %switch.edge.i.i
    i8 13, label %switch.edge.i.i
    i8 0, label %prepend_args.exit.i
  ], !dbg !817

switch.edge.i.i:                                  ; preds = %16, %16, %16, %16, %16, %16
  %18 = getelementptr inbounds i8* %o.0.i.i, i64 1, !dbg !818
  call void @llvm.dbg.value(metadata !{i8* %18}, i64 0, metadata !810) #8, !dbg !818
  br label %16, !dbg !818

; <label>:19                                      ; preds = %16
  %indvars.iv.next.i.i = add nuw nsw i64 %indvars.iv.i.i, 1, !dbg !819
  br label %.critedge20.i.i, !dbg !820

.critedge20.i.i:                                  ; preds = %29, %19
  %20 = phi i8 [ %17, %19 ], [ %30, %29 ]
  %b.1.i.i = phi i8* [ %b.0.ph.i.i, %19 ], [ %22, %29 ]
  %o.1.i.i = phi i8* [ %o.0.i.i, %19 ], [ %o.2.i.i, %29 ]
  %21 = getelementptr inbounds i8* %o.1.i.i, i64 1, !dbg !821
  call void @llvm.dbg.value(metadata !{i8* %21}, i64 0, metadata !810) #8, !dbg !821
  %22 = getelementptr inbounds i8* %b.1.i.i, i64 1, !dbg !821
  call void @llvm.dbg.value(metadata !{i8* %22}, i64 0, metadata !812) #8, !dbg !821
  store i8 %20, i8* %b.1.i.i, align 1, !dbg !821, !tbaa !773
  %23 = icmp eq i8 %20, 92, !dbg !821
  br i1 %23, label %24, label %29, !dbg !821

; <label>:24                                      ; preds = %.critedge20.i.i
  %25 = load i8* %21, align 1, !dbg !821, !tbaa !773
  %26 = icmp eq i8 %25, 0, !dbg !821
  br i1 %26, label %29, label %27, !dbg !821

; <label>:27                                      ; preds = %24
  %28 = getelementptr inbounds i8* %o.1.i.i, i64 2, !dbg !823
  call void @llvm.dbg.value(metadata !{i8* %28}, i64 0, metadata !810) #8, !dbg !823
  store i8 %25, i8* %b.1.i.i, align 1, !dbg !823, !tbaa !773
  br label %29, !dbg !823

; <label>:29                                      ; preds = %27, %24, %.critedge20.i.i
  %o.2.i.i = phi i8* [ %28, %27 ], [ %21, %24 ], [ %21, %.critedge20.i.i ]
  %30 = load i8* %o.2.i.i, align 1, !dbg !823, !tbaa !773
  switch i8 %30, label %.critedge20.i.i [
    i8 0, label %.critedge.i.i
    i8 32, label %.critedge.i.i
    i8 12, label %.critedge.i.i
    i8 11, label %.critedge.i.i
    i8 10, label %.critedge.i.i
    i8 9, label %.critedge.i.i
    i8 13, label %.critedge.i.i
  ], !dbg !823

.critedge.i.i:                                    ; preds = %29, %29, %29, %29, %29, %29, %29
  %31 = getelementptr inbounds i8* %b.1.i.i, i64 2, !dbg !824
  call void @llvm.dbg.value(metadata !{i8* %31}, i64 0, metadata !812) #8, !dbg !824
  store i8 0, i8* %22, align 1, !dbg !824, !tbaa !773
  br label %.outer.i.i, !dbg !819

prepend_args.exit.i:                              ; preds = %16
  %32 = trunc i64 %indvars.iv.i.i to i32, !dbg !825
  call void @llvm.dbg.value(metadata !{i32 %32}, i64 0, metadata !827) #8, !dbg !805
  call void @llvm.dbg.value(metadata !{i32 %argc}, i64 0, metadata !828) #8, !dbg !829
  call void @llvm.dbg.value(metadata !{i8** %argv}, i64 0, metadata !830) #8, !dbg !831
  %33 = add nsw i32 %32, %argc, !dbg !832
  %34 = add nsw i32 %33, 1, !dbg !832
  %35 = sext i32 %34 to i64, !dbg !832
  %36 = shl nsw i64 %35, 3, !dbg !832
  %37 = call noalias i8* @xmalloc(i64 %36) #8, !dbg !832
  %38 = bitcast i8* %37 to i8**, !dbg !832
  call void @llvm.dbg.value(metadata !{i8** %38}, i64 0, metadata !833) #8, !dbg !832
  call void @llvm.dbg.value(metadata !{i32 %33}, i64 0, metadata !61), !dbg !834
  call void @llvm.dbg.value(metadata !{i32 %33}, i64 0, metadata !749), !dbg !751
  call void @llvm.dbg.value(metadata !{i32 %33}, i64 0, metadata !61), !dbg !752
  call void @llvm.dbg.value(metadata !{i32 %33}, i64 0, metadata !61), !dbg !753
  call void @llvm.dbg.value(metadata !{i32 %33}, i64 0, metadata !61), !dbg !756
  call void @llvm.dbg.value(metadata !{i32 %33}, i64 0, metadata !61), !dbg !758
  call void @llvm.dbg.value(metadata !{i32 %33}, i64 0, metadata !61), !dbg !759
  call void @llvm.dbg.value(metadata !{i8** %38}, i64 0, metadata !62), !dbg !835
  call void @llvm.dbg.value(metadata !{i8** %38}, i64 0, metadata !760), !dbg !751
  call void @llvm.dbg.value(metadata !{i8** %38}, i64 0, metadata !62), !dbg !761
  call void @llvm.dbg.value(metadata !{i8** %38}, i64 0, metadata !62), !dbg !752
  call void @llvm.dbg.value(metadata !{i8** %38}, i64 0, metadata !62), !dbg !762
  call void @llvm.dbg.value(metadata !{i8** %38}, i64 0, metadata !62), !dbg !764
  call void @llvm.dbg.value(metadata !{i8** %38}, i64 0, metadata !62), !dbg !765
  %39 = load i8** %argv, align 8, !dbg !836, !tbaa !717
  %40 = getelementptr inbounds i8* %37, i64 8, !dbg !836
  %41 = bitcast i8* %40 to i8**, !dbg !836
  call void @llvm.dbg.value(metadata !{i8** %41}, i64 0, metadata !833) #8, !dbg !836
  store i8* %39, i8** %38, align 8, !dbg !836, !tbaa !717
  call void @llvm.dbg.value(metadata !{i8* %7}, i64 0, metadata !837) #8, !dbg !839
  call void @llvm.dbg.value(metadata !{i8* %15}, i64 0, metadata !840) #8, !dbg !839
  call void @llvm.dbg.value(metadata !{i8** %41}, i64 0, metadata !841) #8, !dbg !839
  call void @llvm.dbg.value(metadata !{i8* %7}, i64 0, metadata !842) #8, !dbg !843
  call void @llvm.dbg.value(metadata !{i8* %15}, i64 0, metadata !844) #8, !dbg !845
  call void @llvm.dbg.value(metadata !45, i64 0, metadata !846) #8, !dbg !847
  br label %.outer.i4.i, !dbg !848

.outer.i4.i:                                      ; preds = %.critedge.i12.i, %prepend_args.exit.i
  %indvars.iv.i1.i = phi i64 [ %indvars.iv.next.i7.i, %.critedge.i12.i ], [ 0, %prepend_args.exit.i ]
  %b.0.ph.i2.i = phi i8* [ %58, %.critedge.i12.i ], [ %15, %prepend_args.exit.i ]
  %o.0.ph.i3.i = phi i8* [ %o.2.i11.i, %.critedge.i12.i ], [ %7, %prepend_args.exit.i ]
  br label %42

; <label>:42                                      ; preds = %switch.edge.i6.i, %.outer.i4.i
  %o.0.i5.i = phi i8* [ %44, %switch.edge.i6.i ], [ %o.0.ph.i3.i, %.outer.i4.i ]
  %43 = load i8* %o.0.i5.i, align 1, !dbg !849, !tbaa !773
  switch i8 %43, label %45 [
    i8 32, label %switch.edge.i6.i
    i8 12, label %switch.edge.i6.i
    i8 11, label %switch.edge.i6.i
    i8 10, label %switch.edge.i6.i
    i8 9, label %switch.edge.i6.i
    i8 13, label %switch.edge.i6.i
    i8 0, label %prepend_args.exit13.i
  ], !dbg !849

switch.edge.i6.i:                                 ; preds = %42, %42, %42, %42, %42, %42
  %44 = getelementptr inbounds i8* %o.0.i5.i, i64 1, !dbg !850
  call void @llvm.dbg.value(metadata !{i8* %44}, i64 0, metadata !842) #8, !dbg !850
  br label %42, !dbg !850

; <label>:45                                      ; preds = %42
  %46 = getelementptr inbounds i8** %41, i64 %indvars.iv.i1.i, !dbg !851
  store i8* %b.0.ph.i2.i, i8** %46, align 8, !dbg !851, !tbaa !717
  %.pre.pre.i.i = load i8* %o.0.i5.i, align 1, !dbg !853, !tbaa !773
  %indvars.iv.next.i7.i = add nuw nsw i64 %indvars.iv.i1.i, 1, !dbg !854
  br label %.critedge20.i10.i, !dbg !855

.critedge20.i10.i:                                ; preds = %56, %45
  %47 = phi i8 [ %.pre.pre.i.i, %45 ], [ %57, %56 ]
  %b.1.i8.i = phi i8* [ %b.0.ph.i2.i, %45 ], [ %49, %56 ]
  %o.1.i9.i = phi i8* [ %o.0.i5.i, %45 ], [ %o.2.i11.i, %56 ]
  %48 = getelementptr inbounds i8* %o.1.i9.i, i64 1, !dbg !853
  call void @llvm.dbg.value(metadata !{i8* %48}, i64 0, metadata !842) #8, !dbg !853
  %49 = getelementptr inbounds i8* %b.1.i8.i, i64 1, !dbg !853
  call void @llvm.dbg.value(metadata !{i8* %49}, i64 0, metadata !844) #8, !dbg !853
  store i8 %47, i8* %b.1.i8.i, align 1, !dbg !853, !tbaa !773
  %50 = icmp eq i8 %47, 92, !dbg !853
  br i1 %50, label %51, label %56, !dbg !853

; <label>:51                                      ; preds = %.critedge20.i10.i
  %52 = load i8* %48, align 1, !dbg !853, !tbaa !773
  %53 = icmp eq i8 %52, 0, !dbg !853
  br i1 %53, label %56, label %54, !dbg !853

; <label>:54                                      ; preds = %51
  %55 = getelementptr inbounds i8* %o.1.i9.i, i64 2, !dbg !856
  call void @llvm.dbg.value(metadata !{i8* %55}, i64 0, metadata !842) #8, !dbg !856
  store i8 %52, i8* %b.1.i8.i, align 1, !dbg !856, !tbaa !773
  br label %56, !dbg !856

; <label>:56                                      ; preds = %54, %51, %.critedge20.i10.i
  %o.2.i11.i = phi i8* [ %55, %54 ], [ %48, %51 ], [ %48, %.critedge20.i10.i ]
  %57 = load i8* %o.2.i11.i, align 1, !dbg !856, !tbaa !773
  switch i8 %57, label %.critedge20.i10.i [
    i8 0, label %.critedge.i12.i
    i8 32, label %.critedge.i12.i
    i8 12, label %.critedge.i12.i
    i8 11, label %.critedge.i12.i
    i8 10, label %.critedge.i12.i
    i8 9, label %.critedge.i12.i
    i8 13, label %.critedge.i12.i
  ], !dbg !856

.critedge.i12.i:                                  ; preds = %56, %56, %56, %56, %56, %56, %56
  %58 = getelementptr inbounds i8* %b.1.i8.i, i64 2, !dbg !857
  call void @llvm.dbg.value(metadata !{i8* %58}, i64 0, metadata !844) #8, !dbg !857
  store i8 0, i8* %49, align 1, !dbg !857, !tbaa !773
  br label %.outer.i4.i, !dbg !854

prepend_args.exit13.i:                            ; preds = %42
  %sext.i = shl i64 %indvars.iv.i1.i, 32, !dbg !838
  %59 = ashr exact i64 %sext.i, 32, !dbg !838
  %60 = getelementptr inbounds i8** %41, i64 %59, !dbg !838
  call void @llvm.dbg.value(metadata !{i8** %60}, i64 0, metadata !833) #8, !dbg !838
  br label %61, !dbg !858

; <label>:61                                      ; preds = %61, %prepend_args.exit13.i
  %.pn.i = phi i8** [ %argv, %prepend_args.exit13.i ], [ %argv.0.i, %61 ]
  %pp.0.i = phi i8** [ %60, %prepend_args.exit13.i ], [ %63, %61 ]
  %argv.0.i = getelementptr inbounds i8** %.pn.i, i64 1, !dbg !836
  %62 = load i8** %argv.0.i, align 8, !dbg !858, !tbaa !717
  %63 = getelementptr inbounds i8** %pp.0.i, i64 1, !dbg !858
  call void @llvm.dbg.value(metadata !{i8** %63}, i64 0, metadata !833) #8, !dbg !858
  store i8* %62, i8** %pp.0.i, align 8, !dbg !858, !tbaa !717
  %64 = icmp eq i8* %62, null, !dbg !858
  br i1 %64, label %prepend_default_options.exit, label %61, !dbg !858

prepend_default_options.exit:                     ; preds = %61, %0, %9
  %argc99 = phi i32 [ %argc, %0 ], [ %argc, %9 ], [ %33, %61 ]
  %argv98 = phi i8** [ %argv, %0 ], [ %argv, %9 ], [ %38, %61 ]
  tail call void @llvm.dbg.value(metadata !767, i64 0, metadata !859), !dbg !861
  %65 = load void (i8*, i64)** getelementptr inbounds ([0 x %struct.matcher]* @matchers, i64 0, i64 0, i32 1), align 8, !dbg !862, !tbaa !864
  store void (i8*, i64)* %65, void (i8*, i64)** @compile, align 8, !dbg !862, !tbaa !717
  %66 = load i64 (i8*, i64, i64*, i8*)** getelementptr inbounds ([0 x %struct.matcher]* @matchers, i64 0, i64 0, i32 2), align 8, !dbg !865, !tbaa !866
  store i64 (i8*, i64, i64*, i8*)* %66, i64 (i8*, i64, i64*, i8*)** @execute, align 8, !dbg !865, !tbaa !717
  %67 = load i8** getelementptr inbounds ([0 x %struct.matcher]* @matchers, i64 0, i64 1, i32 0), align 8, !dbg !867, !tbaa !730
  %68 = icmp eq i8* %67, null, !dbg !867
  br i1 %68, label %69, label %setmatcher.exit.preheader, !dbg !867

; <label>:69                                      ; preds = %prepend_default_options.exit
  %70 = load i8** getelementptr inbounds ([0 x %struct.matcher]* @matchers, i64 0, i64 0, i32 0), align 8, !dbg !869, !tbaa !730
  store i8* %70, i8** @setmatcher.matcher, align 8, !dbg !869, !tbaa !717
  br label %setmatcher.exit.preheader, !dbg !869

setmatcher.exit.preheader:                        ; preds = %prepend_default_options.exit, %69
  %71 = getelementptr inbounds [68 x i8]* %buf.i, i64 0, i64 0, !dbg !870
  %72 = getelementptr inbounds [68 x i8]* %buf.i, i64 0, i64 64, !dbg !871
  %73 = bitcast i8* %72 to i32*, !dbg !874
  %74 = bitcast i64* %value.i.i to i8*, !dbg !788
  %75 = bitcast i64* %value.i to i8*, !dbg !876
  %76 = bitcast i64* %value.i89 to i8*, !dbg !878
  %77 = bitcast i64* %value.i92 to i8*, !dbg !783
  br label %setmatcher.exit, !dbg !790

setmatcher.exit:                                  ; preds = %151, %148, %138, %135, %125, %122, %311, %301, %258, %get_nondigit_option.exit, %get_nondigit_option.exit, %get_nondigit_option.exit, %get_nondigit_option.exit, %243, %241, %348, %165, %166, %167, %168, %169, %171, %172, %173, %174, %175, %176, %177, %178, %184, %251, %252, %253, %254, %264, %265, %266, %267, %268, %269, %270, %271, %272, %273, %340, %362, %370, %373, %375, %376, %162, %163, %158, %248, %262, %261, %282, %287, %286, %278, %333, %334, %323, %353, %setmatcher.exit.preheader
  %78 = phi i32 [ 0, %setmatcher.exit.preheader ], [ %78, %376 ], [ %78, %375 ], [ %78, %373 ], [ %78, %370 ], [ %78, %362 ], [ %78, %353 ], [ %78, %348 ], [ %78, %340 ], [ %78, %334 ], [ %78, %333 ], [ %78, %323 ], [ %78, %278 ], [ %78, %282 ], [ %78, %286 ], [ %78, %287 ], [ %78, %273 ], [ %78, %272 ], [ %78, %271 ], [ %78, %270 ], [ %78, %269 ], [ %78, %268 ], [ %78, %267 ], [ %78, %266 ], [ %78, %265 ], [ %78, %264 ], [ %78, %262 ], [ %78, %261 ], [ %78, %254 ], [ %78, %253 ], [ %78, %252 ], [ %78, %251 ], [ %78, %248 ], [ %78, %243 ], [ %78, %241 ], [ %78, %184 ], [ %78, %178 ], [ %78, %177 ], [ %78, %176 ], [ %78, %175 ], [ 1, %174 ], [ %78, %173 ], [ %78, %172 ], [ %78, %171 ], [ %78, %169 ], [ %78, %168 ], [ %78, %167 ], [ %78, %166 ], [ %78, %165 ], [ %78, %158 ], [ %78, %162 ], [ %78, %163 ], [ %78, %get_nondigit_option.exit ], [ %78, %get_nondigit_option.exit ], [ %78, %get_nondigit_option.exit ], [ %78, %get_nondigit_option.exit ], [ %78, %258 ], [ %78, %301 ], [ %78, %311 ], [ %78, %122 ], [ %78, %125 ], [ %78, %135 ], [ %78, %138 ], [ %78, %148 ], [ %78, %151 ]
  %79 = phi i32 [ 0, %setmatcher.exit.preheader ], [ %112, %376 ], [ %112, %375 ], [ %112, %373 ], [ %112, %370 ], [ %112, %362 ], [ %112, %353 ], [ %112, %348 ], [ %112, %340 ], [ %112, %334 ], [ %112, %333 ], [ %112, %323 ], [ %112, %278 ], [ %112, %282 ], [ %112, %286 ], [ %112, %287 ], [ %112, %273 ], [ %112, %272 ], [ %112, %271 ], [ %112, %270 ], [ %112, %269 ], [ %112, %268 ], [ %112, %267 ], [ %112, %266 ], [ %112, %265 ], [ %112, %264 ], [ %112, %262 ], [ %112, %261 ], [ %112, %254 ], [ %112, %253 ], [ %112, %252 ], [ %112, %251 ], [ %112, %248 ], [ %112, %243 ], [ %112, %241 ], [ %112, %184 ], [ %112, %178 ], [ %112, %177 ], [ %112, %176 ], [ %112, %175 ], [ %112, %174 ], [ %112, %173 ], [ %112, %172 ], [ %112, %171 ], [ %112, %169 ], [ %112, %168 ], [ %112, %167 ], [ %112, %166 ], [ %112, %165 ], [ %112, %158 ], [ %112, %162 ], [ %112, %163 ], [ %112, %get_nondigit_option.exit ], [ %112, %get_nondigit_option.exit ], [ %112, %get_nondigit_option.exit ], [ %112, %get_nondigit_option.exit ], [ %112, %258 ], [ %112, %301 ], [ %112, %311 ], [ %112, %122 ], [ %112, %125 ], [ %112, %135 ], [ %112, %138 ], [ %146, %148 ], [ %152, %151 ]
  %with_filenames.0 = phi i32 [ 0, %setmatcher.exit.preheader ], [ %with_filenames.0, %376 ], [ %with_filenames.0, %375 ], [ %with_filenames.0, %373 ], [ %with_filenames.0, %370 ], [ %with_filenames.0, %362 ], [ %with_filenames.0, %353 ], [ %with_filenames.0, %348 ], [ %with_filenames.0, %340 ], [ %with_filenames.0, %334 ], [ %with_filenames.0, %333 ], [ %with_filenames.0, %323 ], [ %with_filenames.0, %278 ], [ %with_filenames.0, %282 ], [ %with_filenames.0, %286 ], [ %with_filenames.0, %287 ], [ %with_filenames.0, %273 ], [ %with_filenames.0, %272 ], [ %with_filenames.0, %271 ], [ %with_filenames.0, %270 ], [ %with_filenames.0, %269 ], [ %with_filenames.0, %268 ], [ %with_filenames.0, %267 ], [ %with_filenames.0, %266 ], [ %with_filenames.0, %265 ], [ %with_filenames.0, %264 ], [ %with_filenames.0, %262 ], [ %with_filenames.0, %261 ], [ %with_filenames.0, %254 ], [ %with_filenames.0, %253 ], [ %with_filenames.0, %252 ], [ 0, %251 ], [ %with_filenames.0, %248 ], [ %with_filenames.0, %243 ], [ %with_filenames.0, %241 ], [ %with_filenames.0, %184 ], [ %with_filenames.0, %178 ], [ %with_filenames.0, %177 ], [ %with_filenames.0, %176 ], [ %with_filenames.0, %175 ], [ %with_filenames.0, %174 ], [ %with_filenames.0, %173 ], [ %with_filenames.0, %172 ], [ 1, %171 ], [ %with_filenames.0, %169 ], [ %with_filenames.0, %168 ], [ %with_filenames.0, %167 ], [ %with_filenames.0, %166 ], [ %with_filenames.0, %165 ], [ %with_filenames.0, %158 ], [ %with_filenames.0, %162 ], [ %with_filenames.0, %163 ], [ %with_filenames.0, %get_nondigit_option.exit ], [ %with_filenames.0, %get_nondigit_option.exit ], [ %with_filenames.0, %get_nondigit_option.exit ], [ %with_filenames.0, %get_nondigit_option.exit ], [ %with_filenames.0, %258 ], [ %with_filenames.0, %301 ], [ %with_filenames.0, %311 ], [ %with_filenames.0, %122 ], [ %with_filenames.0, %125 ], [ %with_filenames.0, %135 ], [ %with_filenames.0, %138 ], [ %with_filenames.0, %148 ], [ %with_filenames.0, %151 ]
  %keycc.0 = phi i64 [ 0, %setmatcher.exit.preheader ], [ %keycc.0, %376 ], [ %keycc.0, %375 ], [ %keycc.0, %373 ], [ %keycc.0, %370 ], [ %keycc.0, %362 ], [ %keycc.0, %353 ], [ %keycc.0, %348 ], [ %keycc.0, %340 ], [ %keycc.0, %334 ], [ %keycc.0, %333 ], [ %keycc.0, %323 ], [ %keycc.0, %278 ], [ %keycc.0, %282 ], [ %keycc.0, %286 ], [ %keycc.0, %287 ], [ %keycc.0, %273 ], [ %keycc.0, %272 ], [ %keycc.0, %271 ], [ %keycc.0, %270 ], [ %keycc.0, %269 ], [ %keycc.0, %268 ], [ %keycc.0, %267 ], [ %keycc.0, %266 ], [ %keycc.0, %265 ], [ %keycc.0, %264 ], [ %keycc.0, %262 ], [ %keycc.0, %261 ], [ %keycc.0, %254 ], [ %keycc.0, %253 ], [ %keycc.0, %252 ], [ %keycc.0, %251 ], [ %249, %248 ], [ %keycc.1, %243 ], [ %keycc.0, %241 ], [ %189, %184 ], [ %keycc.0, %178 ], [ %keycc.0, %177 ], [ %keycc.0, %176 ], [ %keycc.0, %175 ], [ %keycc.0, %174 ], [ %keycc.0, %173 ], [ %keycc.0, %172 ], [ %keycc.0, %171 ], [ %keycc.0, %169 ], [ %keycc.0, %168 ], [ %keycc.0, %167 ], [ %keycc.0, %166 ], [ %keycc.0, %165 ], [ %keycc.0, %158 ], [ %keycc.0, %162 ], [ %keycc.0, %163 ], [ %keycc.0, %get_nondigit_option.exit ], [ %keycc.0, %get_nondigit_option.exit ], [ %keycc.0, %get_nondigit_option.exit ], [ %keycc.0, %get_nondigit_option.exit ], [ %keycc.0, %258 ], [ %keycc.0, %301 ], [ %keycc.0, %311 ], [ %keycc.0, %122 ], [ %keycc.0, %125 ], [ %keycc.0, %135 ], [ %keycc.0, %138 ], [ %keycc.0, %148 ], [ %keycc.0, %151 ]
  %keys.0 = phi i8* [ null, %setmatcher.exit.preheader ], [ %keys.0, %376 ], [ %keys.0, %375 ], [ %keys.0, %373 ], [ %keys.0, %370 ], [ %keys.0, %362 ], [ %keys.0, %353 ], [ %keys.0, %348 ], [ %keys.0, %340 ], [ %keys.0, %334 ], [ %keys.0, %333 ], [ %keys.0, %323 ], [ %keys.0, %278 ], [ %keys.0, %282 ], [ %keys.0, %286 ], [ %keys.0, %287 ], [ %keys.0, %273 ], [ %keys.0, %272 ], [ %keys.0, %271 ], [ %keys.0, %270 ], [ %keys.0, %269 ], [ %keys.0, %268 ], [ %keys.0, %267 ], [ %keys.0, %266 ], [ %keys.0, %265 ], [ %keys.0, %264 ], [ %keys.0, %262 ], [ %keys.0, %261 ], [ %keys.0, %254 ], [ %keys.0, %253 ], [ %keys.0, %252 ], [ %keys.0, %251 ], [ %keys.1.ph, %248 ], [ %keys.1.ph, %243 ], [ %keys.1.ph, %241 ], [ %190, %184 ], [ %keys.0, %178 ], [ %keys.0, %177 ], [ %keys.0, %176 ], [ %keys.0, %175 ], [ %keys.0, %174 ], [ %keys.0, %173 ], [ %keys.0, %172 ], [ %keys.0, %171 ], [ %keys.0, %169 ], [ %keys.0, %168 ], [ %keys.0, %167 ], [ %keys.0, %166 ], [ %keys.0, %165 ], [ %keys.0, %158 ], [ %keys.0, %162 ], [ %keys.0, %163 ], [ %keys.0, %get_nondigit_option.exit ], [ %keys.0, %get_nondigit_option.exit ], [ %keys.0, %get_nondigit_option.exit ], [ %keys.0, %get_nondigit_option.exit ], [ %keys.0, %258 ], [ %keys.0, %301 ], [ %keys.0, %311 ], [ %keys.0, %122 ], [ %keys.0, %125 ], [ %keys.0, %135 ], [ %keys.0, %138 ], [ %keys.0, %148 ], [ %keys.0, %151 ]
  call void @llvm.dbg.value(metadata !{i32 %argc99}, i64 0, metadata !880) #8, !dbg !790
  call void @llvm.dbg.value(metadata !{i8** %argv98}, i64 0, metadata !881) #8, !dbg !790
  call void @llvm.lifetime.start(i64 68, i8* %71) #8, !dbg !870
  call void @llvm.dbg.declare(metadata !{[68 x i8]* %buf.i}, metadata !552) #8, !dbg !870
  call void @llvm.dbg.value(metadata !{i8* %71}, i64 0, metadata !882) #8, !dbg !883
  call void @llvm.dbg.value(metadata !45, i64 0, metadata !884) #8, !dbg !885
  %this_digit_optind.09.i = load i32* @optind, align 4, !dbg !886
  %80 = call i32 @getopt_long(i32 %argc99, i8** %argv98, i8* getelementptr inbounds ([59 x i8]* @short_options, i64 0, i64 0), %struct.option* bitcast (<{ { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] } }>* @long_options to %struct.option*), i32* null) #8, !dbg !887
  %.off10.i = add i32 %80, -48, !dbg !887
  %81 = icmp ult i32 %.off10.i, 10, !dbg !887
  br i1 %81, label %.lr.ph.i, label %get_nondigit_option.exit, !dbg !887

.lr.ph.i:                                         ; preds = %setmatcher.exit, %.thread.i
  %82 = phi i32 [ %95, %.thread.i ], [ %80, %setmatcher.exit ]
  %this_digit_optind.013.i = phi i32 [ %this_digit_optind.0.i, %.thread.i ], [ %this_digit_optind.09.i, %setmatcher.exit ]
  %p.012.i = phi i8* [ %94, %.thread.i ], [ %71, %setmatcher.exit ]
  %was_digit.011.i = phi i1 [ true, %.thread.i ], [ false, %setmatcher.exit ]
  %83 = load i32* @get_nondigit_option.prev_digit_optind, align 4, !dbg !888, !tbaa !778
  %84 = icmp eq i32 %83, %this_digit_optind.013.i, !dbg !888
  %or.cond.i = and i1 %84, %was_digit.011.i, !dbg !888
  br i1 %or.cond.i, label %85, label %.thread.i, !dbg !888

; <label>:85                                      ; preds = %.lr.ph.i
  %86 = load i8* %71, align 16, !dbg !890, !tbaa !773
  %87 = icmp eq i8 %86, 48, !dbg !890
  %88 = sext i1 %87 to i64, !dbg !890
  %89 = getelementptr inbounds i8* %p.012.i, i64 %88, !dbg !890
  call void @llvm.dbg.value(metadata !{i8* %72}, i64 0, metadata !882) #8, !dbg !890
  %90 = icmp eq i8* %89, %72, !dbg !871
  br i1 %90, label %91, label %.thread.i, !dbg !871

; <label>:91                                      ; preds = %85
  store i32 3026478, i32* %73, align 16, !dbg !874
  %.sum.i = add i64 %88, 3, !dbg !892
  %92 = getelementptr inbounds i8* %p.012.i, i64 %.sum.i, !dbg !892
  call void @llvm.dbg.value(metadata !{i8* %92}, i64 0, metadata !882) #8, !dbg !892
  br label %.critedge.i, !dbg !893

.thread.i:                                        ; preds = %85, %.lr.ph.i
  %p.14.i = phi i8* [ %89, %85 ], [ %71, %.lr.ph.i ]
  %93 = trunc i32 %82 to i8, !dbg !894
  %94 = getelementptr inbounds i8* %p.14.i, i64 1, !dbg !894
  call void @llvm.dbg.value(metadata !{i8* %94}, i64 0, metadata !882) #8, !dbg !894
  store i8 %93, i8* %p.14.i, align 1, !dbg !894, !tbaa !773
  call void @llvm.dbg.value(metadata !895, i64 0, metadata !884) #8, !dbg !896
  store i32 %this_digit_optind.013.i, i32* @get_nondigit_option.prev_digit_optind, align 4, !dbg !897, !tbaa !778
  %this_digit_optind.0.i = load i32* @optind, align 4, !dbg !886
  %95 = call i32 @getopt_long(i32 %argc99, i8** %argv98, i8* getelementptr inbounds ([59 x i8]* @short_options, i64 0, i64 0), %struct.option* bitcast (<{ { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] } }>* @long_options to %struct.option*), i32* null) #8, !dbg !887
  %.off.i = add i32 %95, -48, !dbg !887
  %96 = icmp ult i32 %.off.i, 10, !dbg !887
  br i1 %96, label %.lr.ph.i, label %.critedge.i, !dbg !887

.critedge.i:                                      ; preds = %.thread.i, %91
  %97 = phi i32 [ %82, %91 ], [ %95, %.thread.i ]
  %p.2.i = phi i8* [ %92, %91 ], [ %94, %.thread.i ]
  %98 = icmp eq i8* %p.2.i, %71, !dbg !898
  br i1 %98, label %get_nondigit_option.exit, label %99, !dbg !898

; <label>:99                                      ; preds = %.critedge.i
  store i8 0, i8* %p.2.i, align 1, !dbg !899, !tbaa !773
  call void @llvm.lifetime.start(i64 8, i8* %74) #8, !dbg !788
  call void @llvm.dbg.value(metadata !{i8* %71}, i64 0, metadata !900) #8, !dbg !788
  call void @llvm.dbg.declare(metadata !{i64* %value.i.i}, metadata !538) #8, !dbg !901
  %100 = call i32 @xstrtoumax(i8* %71, i8** null, i32 10, i64* %value.i.i, i8* getelementptr inbounds ([1 x i8]* @.str21, i64 0, i64 0)) #8, !dbg !902
  %101 = icmp eq i32 %100, 0, !dbg !902
  br i1 %101, label %102, label %109, !dbg !902

; <label>:102                                     ; preds = %99
  call void @llvm.dbg.value(metadata !{i64* %value.i.i}, i64 0, metadata !904) #8, !dbg !902
  call void @llvm.dbg.value(metadata !{i64* %value.i.i}, i64 0, metadata !904) #8, !dbg !902
  call void @llvm.dbg.value(metadata !{i64* %value.i.i}, i64 0, metadata !538), !dbg !902
  %103 = load i64* %value.i.i, align 8, !dbg !902, !tbaa !775
  %104 = trunc i64 %103 to i32, !dbg !902
  call void @llvm.dbg.value(metadata !{i32 %104}, i64 0, metadata !74), !dbg !902
  call void @llvm.dbg.value(metadata !{i32 %104}, i64 0, metadata !781), !dbg !783
  call void @llvm.dbg.value(metadata !{i32 %104}, i64 0, metadata !784), !dbg !788
  call void @llvm.dbg.value(metadata !{i32 %104}, i64 0, metadata !789), !dbg !790
  call void @llvm.dbg.value(metadata !{i32 %104}, i64 0, metadata !74), !dbg !791
  call void @llvm.dbg.value(metadata !{i32 %104}, i64 0, metadata !74), !dbg !793
  %105 = icmp sgt i32 %104, -1, !dbg !902
  br i1 %105, label %106, label %109, !dbg !902

; <label>:106                                     ; preds = %102
  %sext.i.i = shl i64 %103, 32, !dbg !902
  %107 = ashr exact i64 %sext.i.i, 32, !dbg !902
  call void @llvm.dbg.value(metadata !{i64* %value.i.i}, i64 0, metadata !904) #8, !dbg !902
  %108 = icmp eq i64 %107, %103, !dbg !902
  br i1 %108, label %get_nondigit_option.exit, label %109, !dbg !902

; <label>:109                                     ; preds = %106, %102, %99
  %110 = phi i32 [ %104, %106 ], [ %104, %102 ], [ %79, %99 ]
  %111 = call i8* @dcgettext(i8* null, i8* getelementptr inbounds ([32 x i8]* @.str92, i64 0, i64 0), i32 5) #8, !dbg !905
  call void (i32, i32, i8*, ...)* @error(i32 2, i32 0, i8* getelementptr inbounds ([7 x i8]* @.str91, i64 0, i64 0), i8* %71, i8* %111) #8, !dbg !907
  br label %get_nondigit_option.exit, !dbg !908

get_nondigit_option.exit:                         ; preds = %setmatcher.exit, %.critedge.i, %106, %109
  %112 = phi i32 [ %110, %109 ], [ %104, %106 ], [ %79, %.critedge.i ], [ %79, %setmatcher.exit ]
  %113 = phi i32 [ %97, %109 ], [ %97, %106 ], [ %97, %.critedge.i ], [ %80, %setmatcher.exit ]
  call void @llvm.lifetime.end(i64 68, i8* %71) #8, !dbg !909
  call void @llvm.dbg.value(metadata !{i32 %113}, i64 0, metadata !71), !dbg !752
  switch i32 %113, label %378 [
    i32 -1, label %379
    i32 65, label %114
    i32 66, label %127
    i32 67, label %140
    i32 68, label %154
    i32 69, label %165
    i32 70, label %166
    i32 80, label %167
    i32 71, label %168
    i32 88, label %169
    i32 72, label %171
    i32 73, label %172
    i32 84, label %173
    i32 85, label %setmatcher.exit
    i32 117, label %setmatcher.exit
    i32 86, label %174
    i32 97, label %175
    i32 98, label %176
    i32 99, label %177
    i32 100, label %178
    i32 101, label %184
    i32 102, label %195
    i32 104, label %251
    i32 105, label %252
    i32 121, label %252
    i32 76, label %253
    i32 108, label %254
    i32 109, label %255
    i32 110, label %264
    i32 111, label %265
    i32 113, label %266
    i32 82, label %267
    i32 114, label %267
    i32 115, label %268
    i32 118, label %269
    i32 119, label %270
    i32 120, label %271
    i32 90, label %272
    i32 122, label %273
    i32 128, label %274
    i32 129, label %289
    i32 131, label %335
    i32 132, label %343
    i32 135, label %357
    i32 130, label %365
    i32 136, label %373
    i32 133, label %375
    i32 134, label %376
    i32 137, label %setmatcher.exit
    i32 0, label %setmatcher.exit
  ], !dbg !752

; <label>:114                                     ; preds = %get_nondigit_option.exit
  %115 = load i8** @optarg, align 8, !dbg !877, !tbaa !717
  call void @llvm.lifetime.start(i64 8, i8* %75) #8, !dbg !876
  call void @llvm.dbg.value(metadata !{i8* %115}, i64 0, metadata !910) #8, !dbg !876
  call void @llvm.dbg.value(metadata !911, i64 0, metadata !912) #8, !dbg !876
  call void @llvm.dbg.declare(metadata !{i64* %value.i}, metadata !538) #8, !dbg !913
  %116 = call i32 @xstrtoumax(i8* %115, i8** null, i32 10, i64* %value.i, i8* getelementptr inbounds ([1 x i8]* @.str21, i64 0, i64 0)) #8, !dbg !914
  %117 = icmp eq i32 %116, 0, !dbg !914
  br i1 %117, label %118, label %125, !dbg !914

; <label>:118                                     ; preds = %114
  call void @llvm.dbg.value(metadata !{i64* %value.i}, i64 0, metadata !915) #8, !dbg !914
  call void @llvm.dbg.value(metadata !{i64* %value.i}, i64 0, metadata !538), !dbg !914
  %119 = load i64* %value.i, align 8, !dbg !914, !tbaa !775
  %120 = trunc i64 %119 to i32, !dbg !914
  store i32 %120, i32* @out_after, align 4, !dbg !914, !tbaa !778
  %121 = icmp sgt i32 %120, -1, !dbg !914
  br i1 %121, label %122, label %125, !dbg !914

; <label>:122                                     ; preds = %118
  %sext.i88 = shl i64 %119, 32, !dbg !914
  %123 = ashr exact i64 %sext.i88, 32, !dbg !914
  call void @llvm.dbg.value(metadata !{i64* %value.i}, i64 0, metadata !915) #8, !dbg !914
  %124 = icmp eq i64 %123, %119, !dbg !914
  br i1 %124, label %setmatcher.exit, label %125, !dbg !914

; <label>:125                                     ; preds = %122, %118, %114
  %126 = call i8* @dcgettext(i8* null, i8* getelementptr inbounds ([32 x i8]* @.str92, i64 0, i64 0), i32 5) #8, !dbg !916
  call void (i32, i32, i8*, ...)* @error(i32 2, i32 0, i8* getelementptr inbounds ([7 x i8]* @.str91, i64 0, i64 0), i8* %115, i8* %126) #8, !dbg !917
  br label %setmatcher.exit, !dbg !918

; <label>:127                                     ; preds = %get_nondigit_option.exit
  %128 = load i8** @optarg, align 8, !dbg !879, !tbaa !717
  call void @llvm.lifetime.start(i64 8, i8* %76) #8, !dbg !878
  call void @llvm.dbg.value(metadata !{i8* %128}, i64 0, metadata !919) #8, !dbg !878
  call void @llvm.dbg.value(metadata !920, i64 0, metadata !921) #8, !dbg !878
  call void @llvm.dbg.declare(metadata !{i64* %value.i89}, metadata !538) #8, !dbg !922
  %129 = call i32 @xstrtoumax(i8* %128, i8** null, i32 10, i64* %value.i89, i8* getelementptr inbounds ([1 x i8]* @.str21, i64 0, i64 0)) #8, !dbg !923
  %130 = icmp eq i32 %129, 0, !dbg !923
  br i1 %130, label %131, label %138, !dbg !923

; <label>:131                                     ; preds = %127
  call void @llvm.dbg.value(metadata !{i64* %value.i89}, i64 0, metadata !924) #8, !dbg !923
  call void @llvm.dbg.value(metadata !{i64* %value.i89}, i64 0, metadata !538), !dbg !923
  %132 = load i64* %value.i89, align 8, !dbg !923, !tbaa !775
  %133 = trunc i64 %132 to i32, !dbg !923
  store i32 %133, i32* @out_before, align 4, !dbg !923, !tbaa !778
  %134 = icmp sgt i32 %133, -1, !dbg !923
  br i1 %134, label %135, label %138, !dbg !923

; <label>:135                                     ; preds = %131
  %sext.i90 = shl i64 %132, 32, !dbg !923
  %136 = ashr exact i64 %sext.i90, 32, !dbg !923
  call void @llvm.dbg.value(metadata !{i64* %value.i89}, i64 0, metadata !924) #8, !dbg !923
  %137 = icmp eq i64 %136, %132, !dbg !923
  br i1 %137, label %setmatcher.exit, label %138, !dbg !923

; <label>:138                                     ; preds = %135, %131, %127
  %139 = call i8* @dcgettext(i8* null, i8* getelementptr inbounds ([32 x i8]* @.str92, i64 0, i64 0), i32 5) #8, !dbg !925
  call void (i32, i32, i8*, ...)* @error(i32 2, i32 0, i8* getelementptr inbounds ([7 x i8]* @.str91, i64 0, i64 0), i8* %128, i8* %139) #8, !dbg !926
  br label %setmatcher.exit, !dbg !927

; <label>:140                                     ; preds = %get_nondigit_option.exit
  %141 = load i8** @optarg, align 8, !dbg !782, !tbaa !717
  call void @llvm.lifetime.start(i64 8, i8* %77) #8, !dbg !783
  call void @llvm.dbg.value(metadata !{i8* %141}, i64 0, metadata !928) #8, !dbg !783
  call void @llvm.dbg.declare(metadata !{i64* %value.i92}, metadata !538) #8, !dbg !929
  %142 = call i32 @xstrtoumax(i8* %141, i8** null, i32 10, i64* %value.i92, i8* getelementptr inbounds ([1 x i8]* @.str21, i64 0, i64 0)) #8, !dbg !930
  %143 = icmp eq i32 %142, 0, !dbg !930
  br i1 %143, label %144, label %151, !dbg !930

; <label>:144                                     ; preds = %140
  call void @llvm.dbg.value(metadata !{i64* %value.i92}, i64 0, metadata !931) #8, !dbg !930
  call void @llvm.dbg.value(metadata !{i64* %value.i92}, i64 0, metadata !538), !dbg !930
  %145 = load i64* %value.i92, align 8, !dbg !930, !tbaa !775
  %146 = trunc i64 %145 to i32, !dbg !930
  call void @llvm.dbg.value(metadata !{i32 %146}, i64 0, metadata !74), !dbg !930
  call void @llvm.dbg.value(metadata !{i32 %146}, i64 0, metadata !781), !dbg !783
  call void @llvm.dbg.value(metadata !{i32 %146}, i64 0, metadata !784), !dbg !788
  call void @llvm.dbg.value(metadata !{i32 %146}, i64 0, metadata !789), !dbg !790
  call void @llvm.dbg.value(metadata !{i32 %146}, i64 0, metadata !74), !dbg !791
  call void @llvm.dbg.value(metadata !{i32 %146}, i64 0, metadata !74), !dbg !793
  %147 = icmp sgt i32 %146, -1, !dbg !930
  br i1 %147, label %148, label %151, !dbg !930

; <label>:148                                     ; preds = %144
  %sext.i93 = shl i64 %145, 32, !dbg !930
  %149 = ashr exact i64 %sext.i93, 32, !dbg !930
  call void @llvm.dbg.value(metadata !{i64* %value.i92}, i64 0, metadata !931) #8, !dbg !930
  %150 = icmp eq i64 %149, %145, !dbg !930
  br i1 %150, label %setmatcher.exit, label %151, !dbg !930

; <label>:151                                     ; preds = %148, %144, %140
  %152 = phi i32 [ %146, %148 ], [ %146, %144 ], [ %112, %140 ]
  %153 = call i8* @dcgettext(i8* null, i8* getelementptr inbounds ([32 x i8]* @.str92, i64 0, i64 0), i32 5) #8, !dbg !932
  call void (i32, i32, i8*, ...)* @error(i32 2, i32 0, i8* getelementptr inbounds ([7 x i8]* @.str91, i64 0, i64 0), i8* %141, i8* %153) #8, !dbg !933
  br label %setmatcher.exit, !dbg !934

; <label>:154                                     ; preds = %get_nondigit_option.exit
  call void @llvm.dbg.value(metadata !935, i64 0, metadata !135), !dbg !936
  %155 = load i8** @optarg, align 8, !dbg !936, !tbaa !717
  %156 = call i32 @strcmp(i8* %155, i8* getelementptr inbounds ([5 x i8]* @.str25, i64 0, i64 0)) #8, !dbg !936
  %157 = icmp eq i32 %156, 0, !dbg !936
  br i1 %157, label %158, label %159, !dbg !936

; <label>:158                                     ; preds = %154
  store i1 false, i1* @devices, align 1
  br label %setmatcher.exit, !dbg !937

; <label>:159                                     ; preds = %154
  call void @llvm.dbg.value(metadata !935, i64 0, metadata !145), !dbg !938
  %160 = call i32 @strcmp(i8* %155, i8* getelementptr inbounds ([5 x i8]* @.str26, i64 0, i64 0)) #8, !dbg !938
  %161 = icmp eq i32 %160, 0, !dbg !938
  br i1 %161, label %162, label %163, !dbg !938

; <label>:162                                     ; preds = %159
  store i1 true, i1* @devices, align 1
  br label %setmatcher.exit, !dbg !939

; <label>:163                                     ; preds = %159
  %164 = call i8* @dcgettext(i8* null, i8* getelementptr inbounds ([23 x i8]* @.str27, i64 0, i64 0), i32 5) #8, !dbg !940
  call void (i32, i32, i8*, ...)* @error(i32 2, i32 0, i8* %164) #8, !dbg !940
  br label %setmatcher.exit

; <label>:165                                     ; preds = %get_nondigit_option.exit
  call fastcc void @setmatcher(i8* getelementptr inbounds ([6 x i8]* @.str28, i64 0, i64 0)), !dbg !941
  br label %setmatcher.exit, !dbg !942

; <label>:166                                     ; preds = %get_nondigit_option.exit
  call fastcc void @setmatcher(i8* getelementptr inbounds ([6 x i8]* @.str29, i64 0, i64 0)), !dbg !943
  br label %setmatcher.exit, !dbg !944

; <label>:167                                     ; preds = %get_nondigit_option.exit
  call fastcc void @setmatcher(i8* getelementptr inbounds ([5 x i8]* @.str30, i64 0, i64 0)), !dbg !945
  br label %setmatcher.exit, !dbg !946

; <label>:168                                     ; preds = %get_nondigit_option.exit
  call fastcc void @setmatcher(i8* getelementptr inbounds ([5 x i8]* @.str22, i64 0, i64 0)), !dbg !947
  br label %setmatcher.exit, !dbg !948

; <label>:169                                     ; preds = %get_nondigit_option.exit
  %170 = load i8** @optarg, align 8, !dbg !949, !tbaa !717
  call fastcc void @setmatcher(i8* %170), !dbg !949
  br label %setmatcher.exit, !dbg !950

; <label>:171                                     ; preds = %get_nondigit_option.exit
  call void @llvm.dbg.value(metadata !895, i64 0, metadata !70), !dbg !951
  store i1 false, i1* @no_filenames, align 1
  br label %setmatcher.exit, !dbg !952

; <label>:172                                     ; preds = %get_nondigit_option.exit
  store i32 2, i32* @binary_files, align 4, !dbg !953, !tbaa !773
  br label %setmatcher.exit, !dbg !954

; <label>:173                                     ; preds = %get_nondigit_option.exit
  store i1 true, i1* @align_tabs, align 1
  br label %setmatcher.exit, !dbg !955

; <label>:174                                     ; preds = %get_nondigit_option.exit
  br label %setmatcher.exit, !dbg !956

; <label>:175                                     ; preds = %get_nondigit_option.exit
  store i32 1, i32* @binary_files, align 4, !dbg !957, !tbaa !773
  br label %setmatcher.exit, !dbg !958

; <label>:176                                     ; preds = %get_nondigit_option.exit
  store i1 true, i1* @out_byte, align 1
  br label %setmatcher.exit, !dbg !959

; <label>:177                                     ; preds = %get_nondigit_option.exit
  store i1 true, i1* @count_matches, align 1
  br label %setmatcher.exit, !dbg !960

; <label>:178                                     ; preds = %get_nondigit_option.exit
  %179 = load i8** @optarg, align 8, !dbg !961, !tbaa !717
  %180 = load void ()** @argmatch_die, align 8, !dbg !961, !tbaa !717
  %181 = call i64 @__xargmatch_internal(i8* getelementptr inbounds ([14 x i8]* @.str31, i64 0, i64 0), i8* %179, i8** getelementptr inbounds ([4 x i8*]* @directories_args, i64 0, i64 0), i8* bitcast ([3 x i32]* @directories_types to i8*), i64 4, void ()* %180) #8, !dbg !961
  %182 = getelementptr inbounds [3 x i32]* @directories_types, i64 0, i64 %181, !dbg !961
  %183 = load i32* %182, align 4, !dbg !961, !tbaa !773
  store i32 %183, i32* @directories, align 4, !dbg !961, !tbaa !773
  br label %setmatcher.exit, !dbg !962

; <label>:184                                     ; preds = %get_nondigit_option.exit
  %185 = load i8** @optarg, align 8, !dbg !963, !tbaa !717
  %186 = call i64 @strlen(i8* %185) #12, !dbg !963
  %sext86 = shl i64 %186, 32, !dbg !964
  %187 = ashr exact i64 %sext86, 32, !dbg !964
  %188 = add i64 %187, %keycc.0, !dbg !964
  %189 = add i64 %188, 1, !dbg !964
  %190 = call i8* @xrealloc(i8* %keys.0, i64 %189) #8, !dbg !964
  call void @llvm.dbg.value(metadata !{i8* %190}, i64 0, metadata !63), !dbg !964
  %191 = getelementptr inbounds i8* %190, i64 %keycc.0, !dbg !965
  %192 = load i8** @optarg, align 8, !dbg !965, !tbaa !717
  %193 = call i8* @strcpy(i8* %191, i8* %192) #8, !dbg !965
  call void @llvm.dbg.value(metadata !{i64 %188}, i64 0, metadata !64), !dbg !966
  call void @llvm.dbg.value(metadata !{i64 %189}, i64 0, metadata !64), !dbg !967
  %194 = getelementptr inbounds i8* %190, i64 %188, !dbg !967
  store i8 10, i8* %194, align 1, !dbg !967, !tbaa !773
  br label %setmatcher.exit, !dbg !968

; <label>:195                                     ; preds = %get_nondigit_option.exit
  call void @llvm.dbg.value(metadata !969, i64 0, metadata !151), !dbg !970
  %196 = load i8** @optarg, align 8, !dbg !971, !tbaa !717
  call void @llvm.dbg.value(metadata !{i8* %196}, i64 0, metadata !152), !dbg !971
  %197 = load i8* %196, align 1, !dbg !971, !tbaa !773
  %198 = icmp eq i8 %197, 45, !dbg !972
  br i1 %198, label %199, label %.thread, !dbg !972

; <label>:199                                     ; preds = %195
  %200 = getelementptr inbounds i8* %196, i64 1, !dbg !974
  %201 = load i8* %200, align 1, !dbg !974, !tbaa !773
  %202 = icmp eq i8 %201, 0, !dbg !970
  br i1 %202, label %203, label %.thread, !dbg !970

; <label>:203                                     ; preds = %199
  %204 = load %struct._IO_FILE** @stdin, align 8, !dbg !970, !tbaa !717
  br label %206, !dbg !970

.thread:                                          ; preds = %195, %199
  %205 = call %struct._IO_FILE* @fopen(i8* %196, i8* getelementptr inbounds ([2 x i8]* @.str33, i64 0, i64 0)) #8, !dbg !976
  br label %206, !dbg !976

; <label>:206                                     ; preds = %.thread, %203
  %207 = phi %struct._IO_FILE* [ %204, %203 ], [ %205, %.thread ], !dbg !976
  call void @llvm.dbg.value(metadata !{%struct._IO_FILE* %207}, i64 0, metadata !75), !dbg !976
  %208 = icmp eq %struct._IO_FILE* %207, null, !dbg !977
  br i1 %208, label %209, label %.preheader104, !dbg !977

; <label>:209                                     ; preds = %206
  %210 = call i32* @__errno_location() #1, !dbg !979
  %211 = load i32* %210, align 4, !dbg !979, !tbaa !778
  %212 = load i8** @optarg, align 8, !dbg !979, !tbaa !717
  call void (i32, i32, i8*, ...)* @error(i32 2, i32 %211, i8* getelementptr inbounds ([3 x i8]* @.str3, i64 0, i64 0), i8* %212) #8, !dbg !979
  br label %.preheader104, !dbg !979

.preheader104:                                    ; preds = %206, %209
  %213 = add i64 %keycc.0, 1, !dbg !980
  br label %214, !dbg !980

; <label>:214                                     ; preds = %214, %.preheader104
  %keyalloc.0 = phi i64 [ %216, %214 ], [ 1, %.preheader104 ]
  %215 = icmp ugt i64 %keyalloc.0, %213, !dbg !980
  %216 = shl i64 %keyalloc.0, 1, !dbg !980
  call void @llvm.dbg.value(metadata !{i64 %216}, i64 0, metadata !69), !dbg !980
  br i1 %215, label %217, label %214, !dbg !980

; <label>:217                                     ; preds = %214
  %218 = call i8* @xrealloc(i8* %keys.0, i64 %keyalloc.0) #8, !dbg !982
  call void @llvm.dbg.value(metadata !{i8* %218}, i64 0, metadata !63), !dbg !982
  call void @llvm.dbg.value(metadata !{i64 %keycc.0}, i64 0, metadata !68), !dbg !983
  %219 = getelementptr inbounds %struct._IO_FILE* %207, i64 0, i32 0, !dbg !984
  br label %.outer, !dbg !987

.outer:                                           ; preds = %234, %217
  %keyalloc.1.ph = phi i64 [ %keyalloc.0, %217 ], [ %235, %234 ]
  %keycc.1.ph = phi i64 [ %keycc.0, %217 ], [ %220, %234 ]
  %keys.1.ph = phi i8* [ %218, %217 ], [ %236, %234 ]
  %220 = add i64 %keyalloc.1.ph, -1, !dbg !988
  br label %221

; <label>:221                                     ; preds = %.outer, %230
  %keycc.1 = phi i64 [ %232, %230 ], [ %keycc.1.ph, %.outer ]
  tail call void @llvm.dbg.value(metadata !{%struct._IO_FILE* %207}, i64 0, metadata !989), !dbg !990
  %222 = load i32* %219, align 4, !dbg !984, !tbaa !991
  %.lobit.i = and i32 %222, 16, !dbg !984
  %223 = icmp eq i32 %.lobit.i, 0, !dbg !986
  br i1 %223, label %224, label %.critedge, !dbg !986

; <label>:224                                     ; preds = %221
  %225 = getelementptr inbounds i8* %keys.1.ph, i64 %keycc.1, !dbg !988
  %226 = sub i64 %220, %keycc.1, !dbg !988
  %227 = call i64 @fread_unlocked(i8* %225, i64 1, i64 %226, %struct._IO_FILE* %207) #8, !dbg !988
  %228 = trunc i64 %227 to i32, !dbg !988
  call void @llvm.dbg.value(metadata !{i32 %228}, i64 0, metadata !72), !dbg !988
  %229 = icmp sgt i32 %228, 0, !dbg !988
  br i1 %229, label %230, label %.critedge

; <label>:230                                     ; preds = %224
  %sext = shl i64 %227, 32, !dbg !994
  %231 = ashr exact i64 %sext, 32, !dbg !994
  %232 = add i64 %231, %keycc.1, !dbg !994
  call void @llvm.dbg.value(metadata !{i64 %220}, i64 0, metadata !64), !dbg !994
  %233 = icmp eq i64 %232, %220, !dbg !996
  br i1 %233, label %234, label %221, !dbg !996

; <label>:234                                     ; preds = %230
  %235 = shl i64 %keyalloc.1.ph, 1, !dbg !998
  call void @llvm.dbg.value(metadata !{i64 %235}, i64 0, metadata !69), !dbg !998
  %236 = call i8* @xrealloc(i8* %keys.1.ph, i64 %235) #8, !dbg !998
  call void @llvm.dbg.value(metadata !{i8* %236}, i64 0, metadata !63), !dbg !998
  br label %.outer, !dbg !998

.critedge:                                        ; preds = %221, %224
  %237 = load %struct._IO_FILE** @stdin, align 8, !dbg !999, !tbaa !717
  %238 = icmp eq %struct._IO_FILE* %207, %237, !dbg !999
  br i1 %238, label %241, label %239, !dbg !999

; <label>:239                                     ; preds = %.critedge
  %240 = call i32 @fclose(%struct._IO_FILE* %207) #8, !dbg !1001
  br label %241, !dbg !1001

; <label>:241                                     ; preds = %.critedge, %239
  %242 = icmp eq i64 %keycc.0, %keycc.1, !dbg !1002
  br i1 %242, label %setmatcher.exit, label %243, !dbg !1002

; <label>:243                                     ; preds = %241
  %244 = add i64 %keycc.1, -1, !dbg !1002
  %245 = getelementptr inbounds i8* %keys.1.ph, i64 %244, !dbg !1002
  %246 = load i8* %245, align 1, !dbg !1002, !tbaa !773
  %247 = icmp eq i8 %246, 10, !dbg !1002
  br i1 %247, label %setmatcher.exit, label %248, !dbg !1002

; <label>:248                                     ; preds = %243
  %249 = add i64 %keycc.1, 1, !dbg !1004
  call void @llvm.dbg.value(metadata !{i64 %249}, i64 0, metadata !64), !dbg !1004
  %250 = getelementptr inbounds i8* %keys.1.ph, i64 %keycc.1, !dbg !1004
  store i8 10, i8* %250, align 1, !dbg !1004, !tbaa !773
  br label %setmatcher.exit, !dbg !1004

; <label>:251                                     ; preds = %get_nondigit_option.exit
  call void @llvm.dbg.value(metadata !45, i64 0, metadata !70), !dbg !1005
  store i1 true, i1* @no_filenames, align 1
  br label %setmatcher.exit, !dbg !1006

; <label>:252                                     ; preds = %get_nondigit_option.exit, %get_nondigit_option.exit
  store i32 1, i32* @match_icase, align 4, !dbg !1007, !tbaa !778
  br label %setmatcher.exit, !dbg !1008

; <label>:253                                     ; preds = %get_nondigit_option.exit
  store i32 -1, i32* @list_files, align 4, !dbg !1009, !tbaa !778
  br label %setmatcher.exit, !dbg !1010

; <label>:254                                     ; preds = %get_nondigit_option.exit
  store i32 1, i32* @list_files, align 4, !dbg !1011, !tbaa !778
  br label %setmatcher.exit, !dbg !1012

; <label>:255                                     ; preds = %get_nondigit_option.exit
  call void @llvm.dbg.declare(metadata !{i64* %value}, metadata !155), !dbg !1013
  %256 = load i8** @optarg, align 8, !dbg !1014, !tbaa !717
  %257 = call i32 @xstrtoumax(i8* %256, i8** null, i32 10, i64* %value, i8* getelementptr inbounds ([1 x i8]* @.str21, i64 0, i64 0)) #8, !dbg !1014
  switch i32 %257, label %262 [
    i32 0, label %258
    i32 1, label %261
  ], !dbg !1014

; <label>:258                                     ; preds = %255
  call void @llvm.dbg.value(metadata !{i64* %value}, i64 0, metadata !155), !dbg !1015
  %259 = load i64* %value, align 8, !dbg !1015, !tbaa !775
  store i64 %259, i64* @max_count, align 8, !dbg !1015, !tbaa !775
  %260 = icmp sgt i64 %259, -1, !dbg !1017
  call void @llvm.dbg.value(metadata !{i64* %value}, i64 0, metadata !155), !dbg !1017
  call void @llvm.dbg.value(metadata !{i64* %value}, i64 0, metadata !155), !dbg !1017
  br i1 %260, label %setmatcher.exit, label %261, !dbg !1017

; <label>:261                                     ; preds = %258, %255
  store i64 9223372036854775807, i64* @max_count, align 8, !dbg !1019, !tbaa !775
  br label %setmatcher.exit, !dbg !1020

; <label>:262                                     ; preds = %255
  %263 = call i8* @dcgettext(i8* null, i8* getelementptr inbounds ([18 x i8]* @.str34, i64 0, i64 0), i32 5) #8, !dbg !1021
  call void (i32, i32, i8*, ...)* @error(i32 2, i32 0, i8* %263) #8, !dbg !1021
  br label %setmatcher.exit, !dbg !1022

; <label>:264                                     ; preds = %get_nondigit_option.exit
  store i1 true, i1* @out_line, align 1
  br label %setmatcher.exit, !dbg !1023

; <label>:265                                     ; preds = %get_nondigit_option.exit
  store i1 true, i1* @only_matching, align 1
  br label %setmatcher.exit, !dbg !1024

; <label>:266                                     ; preds = %get_nondigit_option.exit
  store i1 true, i1* @exit_on_match, align 1
  store volatile i32 0, i32* @exit_failure, align 4, !dbg !1025, !tbaa !778
  br label %setmatcher.exit, !dbg !1026

; <label>:267                                     ; preds = %get_nondigit_option.exit, %get_nondigit_option.exit
  store i32 3, i32* @directories, align 4, !dbg !1027, !tbaa !773
  br label %setmatcher.exit, !dbg !1028

; <label>:268                                     ; preds = %get_nondigit_option.exit
  store i1 true, i1* @suppress_errors, align 1
  br label %setmatcher.exit, !dbg !1029

; <label>:269                                     ; preds = %get_nondigit_option.exit
  store i32 1, i32* @out_invert, align 4, !dbg !1030, !tbaa !778
  br label %setmatcher.exit, !dbg !1031

; <label>:270                                     ; preds = %get_nondigit_option.exit
  store i32 1, i32* @match_words, align 4, !dbg !1032, !tbaa !778
  br label %setmatcher.exit, !dbg !1033

; <label>:271                                     ; preds = %get_nondigit_option.exit
  store i32 1, i32* @match_lines, align 4, !dbg !1034, !tbaa !778
  br label %setmatcher.exit, !dbg !1035

; <label>:272                                     ; preds = %get_nondigit_option.exit
  store i1 false, i1* @filename_mask, align 1
  br label %setmatcher.exit, !dbg !1036

; <label>:273                                     ; preds = %get_nondigit_option.exit
  store i8 0, i8* @eolbyte, align 1, !dbg !1037, !tbaa !773
  br label %setmatcher.exit, !dbg !1038

; <label>:274                                     ; preds = %get_nondigit_option.exit
  call void @llvm.dbg.value(metadata !1039, i64 0, metadata !162), !dbg !1040
  %275 = load i8** @optarg, align 8, !dbg !1040, !tbaa !717
  %276 = call i32 @strcmp(i8* %275, i8* getelementptr inbounds ([7 x i8]* @.str35, i64 0, i64 0)) #8, !dbg !1040
  %277 = icmp eq i32 %276, 0, !dbg !1040
  br i1 %277, label %278, label %279, !dbg !1040

; <label>:278                                     ; preds = %274
  store i32 0, i32* @binary_files, align 4, !dbg !1041, !tbaa !773
  br label %setmatcher.exit, !dbg !1041

; <label>:279                                     ; preds = %274
  call void @llvm.dbg.value(metadata !935, i64 0, metadata !169), !dbg !1042
  %280 = call i32 @strcmp(i8* %275, i8* getelementptr inbounds ([5 x i8]* @.str36, i64 0, i64 0)) #8, !dbg !1042
  %281 = icmp eq i32 %280, 0, !dbg !1042
  br i1 %281, label %282, label %283, !dbg !1042

; <label>:282                                     ; preds = %279
  store i32 1, i32* @binary_files, align 4, !dbg !1043, !tbaa !773
  br label %setmatcher.exit, !dbg !1043

; <label>:283                                     ; preds = %279
  call void @llvm.dbg.value(metadata !1044, i64 0, metadata !176), !dbg !1045
  %284 = call i32 @strcmp(i8* %275, i8* getelementptr inbounds ([14 x i8]* @.str37, i64 0, i64 0)) #8, !dbg !1045
  %285 = icmp eq i32 %284, 0, !dbg !1045
  br i1 %285, label %286, label %287, !dbg !1045

; <label>:286                                     ; preds = %283
  store i32 2, i32* @binary_files, align 4, !dbg !1046, !tbaa !773
  br label %setmatcher.exit, !dbg !1046

; <label>:287                                     ; preds = %283
  %288 = call i8* @dcgettext(i8* null, i8* getelementptr inbounds ([26 x i8]* @.str38, i64 0, i64 0), i32 5) #8, !dbg !1047
  call void (i32, i32, i8*, ...)* @error(i32 2, i32 0, i8* %288) #8, !dbg !1047
  br label %setmatcher.exit

; <label>:289                                     ; preds = %get_nondigit_option.exit
  %290 = load i8** @optarg, align 8, !dbg !1048, !tbaa !717
  %291 = icmp eq i8* %290, null, !dbg !1048
  br i1 %291, label %322, label %292, !dbg !1048

; <label>:292                                     ; preds = %289
  %293 = call i32 @strcasecmp(i8* %290, i8* getelementptr inbounds ([7 x i8]* @.str39, i64 0, i64 0)) #12, !dbg !1050
  %294 = icmp eq i32 %293, 0, !dbg !1050
  br i1 %294, label %301, label %295, !dbg !1050

; <label>:295                                     ; preds = %292
  %296 = call i32 @strcasecmp(i8* %290, i8* getelementptr inbounds ([4 x i8]* @.str40, i64 0, i64 0)) #12, !dbg !1050
  %297 = icmp eq i32 %296, 0, !dbg !1050
  br i1 %297, label %301, label %298, !dbg !1050

; <label>:298                                     ; preds = %295
  %299 = call i32 @strcasecmp(i8* %290, i8* getelementptr inbounds ([6 x i8]* @.str41, i64 0, i64 0)) #12, !dbg !1053
  %300 = icmp eq i32 %299, 0, !dbg !1053
  br i1 %300, label %301, label %302, !dbg !1053

; <label>:301                                     ; preds = %298, %295, %292
  store i32 1, i32* @color_option, align 4, !dbg !1054, !tbaa !778
  br label %setmatcher.exit, !dbg !1054

; <label>:302                                     ; preds = %298
  %303 = call i32 @strcasecmp(i8* %290, i8* getelementptr inbounds ([6 x i8]* @.str42, i64 0, i64 0)) #12, !dbg !1055
  %304 = icmp eq i32 %303, 0, !dbg !1055
  br i1 %304, label %311, label %305, !dbg !1055

; <label>:305                                     ; preds = %302
  %306 = call i32 @strcasecmp(i8* %290, i8* getelementptr inbounds ([3 x i8]* @.str43, i64 0, i64 0)) #12, !dbg !1055
  %307 = icmp eq i32 %306, 0, !dbg !1055
  br i1 %307, label %311, label %308, !dbg !1055

; <label>:308                                     ; preds = %305
  %309 = call i32 @strcasecmp(i8* %290, i8* getelementptr inbounds ([5 x i8]* @.str44, i64 0, i64 0)) #12, !dbg !1057
  %310 = icmp eq i32 %309, 0, !dbg !1057
  br i1 %310, label %311, label %312, !dbg !1057

; <label>:311                                     ; preds = %308, %305, %302
  store i32 0, i32* @color_option, align 4, !dbg !1058, !tbaa !778
  br label %setmatcher.exit, !dbg !1058

; <label>:312                                     ; preds = %308
  %313 = call i32 @strcasecmp(i8* %290, i8* getelementptr inbounds ([5 x i8]* @.str45, i64 0, i64 0)) #12, !dbg !1059
  %314 = icmp eq i32 %313, 0, !dbg !1059
  br i1 %314, label %321, label %315, !dbg !1059

; <label>:315                                     ; preds = %312
  %316 = call i32 @strcasecmp(i8* %290, i8* getelementptr inbounds ([4 x i8]* @.str46, i64 0, i64 0)) #12, !dbg !1059
  %317 = icmp eq i32 %316, 0, !dbg !1059
  br i1 %317, label %321, label %318, !dbg !1059

; <label>:318                                     ; preds = %315
  %319 = call i32 @strcasecmp(i8* %290, i8* getelementptr inbounds ([7 x i8]* @.str47, i64 0, i64 0)) #12, !dbg !1061
  %320 = icmp eq i32 %319, 0, !dbg !1061
  br i1 %320, label %321, label %323, !dbg !1061

; <label>:321                                     ; preds = %318, %315, %312
  store i32 2, i32* @color_option, align 4, !dbg !1062, !tbaa !778
  br label %.thread100, !dbg !1062

; <label>:322                                     ; preds = %289
  store i32 2, i32* @color_option, align 4, !dbg !1063, !tbaa !778
  br label %.thread100

; <label>:323                                     ; preds = %318
  store i32 1, i32* @show_help, align 4, !dbg !1064, !tbaa !778
  %.pr = load i32* @color_option, align 4, !dbg !1065, !tbaa !778
  %324 = icmp eq i32 %.pr, 2, !dbg !1065
  br i1 %324, label %.thread100, label %setmatcher.exit, !dbg !1065

.thread100:                                       ; preds = %322, %321, %323
  %325 = call i32 @isatty(i32 1) #8, !dbg !1066
  %326 = icmp eq i32 %325, 0, !dbg !1066
  br i1 %326, label %334, label %327, !dbg !1066

; <label>:327                                     ; preds = %.thread100
  %328 = call i8* @getenv(i8* getelementptr inbounds ([5 x i8]* @.str48, i64 0, i64 0)) #8, !dbg !1066
  call void @llvm.dbg.value(metadata !{i8* %328}, i64 0, metadata !180), !dbg !1066
  %329 = icmp eq i8* %328, null, !dbg !1066
  br i1 %329, label %334, label %330, !dbg !1066

; <label>:330                                     ; preds = %327
  call void @llvm.dbg.value(metadata !935, i64 0, metadata !188), !dbg !1067
  %331 = call i32 @strcmp(i8* %328, i8* getelementptr inbounds ([5 x i8]* @.str49, i64 0, i64 0)) #8, !dbg !1067
  %332 = icmp eq i32 %331, 0, !dbg !1067
  br i1 %332, label %334, label %333, !dbg !1067

; <label>:333                                     ; preds = %330
  store i32 1, i32* @color_option, align 4, !dbg !1068, !tbaa !778
  br label %setmatcher.exit, !dbg !1068

; <label>:334                                     ; preds = %327, %.thread100, %330
  store i32 0, i32* @color_option, align 4, !dbg !1069, !tbaa !778
  br label %setmatcher.exit

; <label>:335                                     ; preds = %get_nondigit_option.exit
  %336 = load %struct.exclude** @excluded_patterns, align 8, !dbg !1070, !tbaa !717
  %337 = icmp eq %struct.exclude* %336, null, !dbg !1070
  br i1 %337, label %338, label %340, !dbg !1070

; <label>:338                                     ; preds = %335
  %339 = call %struct.exclude* @new_exclude() #8, !dbg !1072
  store %struct.exclude* %339, %struct.exclude** @excluded_patterns, align 8, !dbg !1072, !tbaa !717
  br label %340, !dbg !1072

; <label>:340                                     ; preds = %335, %338
  %341 = phi %struct.exclude* [ %336, %335 ], [ %339, %338 ]
  %342 = load i8** @optarg, align 8, !dbg !1073, !tbaa !717
  call void @add_exclude(%struct.exclude* %341, i8* %342, i32 268435456) #8, !dbg !1073
  br label %setmatcher.exit, !dbg !1074

; <label>:343                                     ; preds = %get_nondigit_option.exit
  %344 = load %struct.exclude** @excluded_patterns, align 8, !dbg !1075, !tbaa !717
  %345 = icmp eq %struct.exclude* %344, null, !dbg !1075
  br i1 %345, label %346, label %348, !dbg !1075

; <label>:346                                     ; preds = %343
  %347 = call %struct.exclude* @new_exclude() #8, !dbg !1077
  store %struct.exclude* %347, %struct.exclude** @excluded_patterns, align 8, !dbg !1077, !tbaa !717
  br label %348, !dbg !1077

; <label>:348                                     ; preds = %343, %346
  %349 = phi %struct.exclude* [ %344, %343 ], [ %347, %346 ]
  %350 = load i8** @optarg, align 8, !dbg !1078, !tbaa !717
  %351 = call i32 @add_exclude_file(void (%struct.exclude*, i8*, i32)* @add_exclude, %struct.exclude* %349, i8* %350, i32 268435456, i8 signext 10) #8, !dbg !1078
  %352 = icmp eq i32 %351, 0, !dbg !1078
  br i1 %352, label %setmatcher.exit, label %353, !dbg !1078

; <label>:353                                     ; preds = %348
  %354 = call i32* @__errno_location() #1, !dbg !1080
  %355 = load i32* %354, align 4, !dbg !1080, !tbaa !778
  %356 = load i8** @optarg, align 8, !dbg !1080, !tbaa !717
  call void (i32, i32, i8*, ...)* @error(i32 2, i32 %355, i8* getelementptr inbounds ([3 x i8]* @.str3, i64 0, i64 0), i8* %356) #8, !dbg !1080
  br label %setmatcher.exit, !dbg !1082

; <label>:357                                     ; preds = %get_nondigit_option.exit
  %358 = load %struct.exclude** @excluded_directory_patterns, align 8, !dbg !1083, !tbaa !717
  %359 = icmp eq %struct.exclude* %358, null, !dbg !1083
  br i1 %359, label %360, label %362, !dbg !1083

; <label>:360                                     ; preds = %357
  %361 = call %struct.exclude* @new_exclude() #8, !dbg !1085
  store %struct.exclude* %361, %struct.exclude** @excluded_directory_patterns, align 8, !dbg !1085, !tbaa !717
  br label %362, !dbg !1085

; <label>:362                                     ; preds = %357, %360
  %363 = phi %struct.exclude* [ %358, %357 ], [ %361, %360 ]
  %364 = load i8** @optarg, align 8, !dbg !1086, !tbaa !717
  call void @add_exclude(%struct.exclude* %363, i8* %364, i32 268435456) #8, !dbg !1086
  br label %setmatcher.exit, !dbg !1087

; <label>:365                                     ; preds = %get_nondigit_option.exit
  %366 = load %struct.exclude** @included_patterns, align 8, !dbg !1088, !tbaa !717
  %367 = icmp eq %struct.exclude* %366, null, !dbg !1088
  br i1 %367, label %368, label %370, !dbg !1088

; <label>:368                                     ; preds = %365
  %369 = call %struct.exclude* @new_exclude() #8, !dbg !1090
  store %struct.exclude* %369, %struct.exclude** @included_patterns, align 8, !dbg !1090, !tbaa !717
  br label %370, !dbg !1090

; <label>:370                                     ; preds = %365, %368
  %371 = phi %struct.exclude* [ %366, %365 ], [ %369, %368 ]
  %372 = load i8** @optarg, align 8, !dbg !1091, !tbaa !717
  call void @add_exclude(%struct.exclude* %371, i8* %372, i32 805306368) #8, !dbg !1091
  br label %setmatcher.exit, !dbg !1092

; <label>:373                                     ; preds = %get_nondigit_option.exit
  %374 = load i8** @optarg, align 8, !dbg !1093, !tbaa !717
  store i8* %374, i8** @group_separator, align 8, !dbg !1093, !tbaa !717
  br label %setmatcher.exit, !dbg !1094

; <label>:375                                     ; preds = %get_nondigit_option.exit
  store i1 true, i1* @line_buffered, align 1
  br label %setmatcher.exit, !dbg !1095

; <label>:376                                     ; preds = %get_nondigit_option.exit
  %377 = load i8** @optarg, align 8, !dbg !1096, !tbaa !717
  store i8* %377, i8** @label, align 8, !dbg !1096, !tbaa !717
  br label %setmatcher.exit, !dbg !1097

; <label>:378                                     ; preds = %get_nondigit_option.exit
  call void @usage(i32 2) #13, !dbg !1098
  unreachable, !dbg !1098

; <label>:379                                     ; preds = %get_nondigit_option.exit
  %.b84 = load i1* @exit_on_match, align 1
  br i1 %.b84, label %380, label %._crit_edge, !dbg !1099

._crit_edge:                                      ; preds = %379
  %.pre = load i32* @list_files, align 4, !dbg !1101, !tbaa !778
  br label %381, !dbg !1099

; <label>:380                                     ; preds = %379
  store i32 0, i32* @list_files, align 4, !dbg !1103, !tbaa !778
  br label %381, !dbg !1103

; <label>:381                                     ; preds = %._crit_edge, %380
  %382 = phi i32 [ %.pre, %._crit_edge ], [ 0, %380 ]
  %383 = zext i1 %.b84 to i32
  %384 = or i32 %383, %382, !dbg !1101
  %385 = icmp eq i32 %384, 0, !dbg !1101
  br i1 %385, label %._crit_edge178, label %386, !dbg !1101

._crit_edge178:                                   ; preds = %381
  %.b82.pre = load i1* @count_matches, align 1
  %.pre180 = load i32* @done_on_match, align 4, !dbg !1104, !tbaa !778
  br label %387, !dbg !1101

; <label>:386                                     ; preds = %381
  store i1 false, i1* @count_matches, align 1
  store i32 1, i32* @done_on_match, align 4, !dbg !1105, !tbaa !778
  br label %387, !dbg !1107

; <label>:387                                     ; preds = %._crit_edge178, %386
  %388 = phi i32 [ %.pre180, %._crit_edge178 ], [ 1, %386 ]
  %.b82 = phi i1 [ %.b82.pre, %._crit_edge178 ], [ false, %386 ]
  %389 = zext i1 %.b82 to i32
  %390 = or i32 %389, %388, !dbg !1104
  store i32 %390, i32* @out_quiet, align 4, !dbg !1104, !tbaa !778
  %391 = load i32* @out_after, align 4, !dbg !1108, !tbaa !778
  %392 = icmp slt i32 %391, 0, !dbg !1108
  br i1 %392, label %393, label %394, !dbg !1108

; <label>:393                                     ; preds = %387
  store i32 %112, i32* @out_after, align 4, !dbg !791, !tbaa !778
  br label %394, !dbg !791

; <label>:394                                     ; preds = %393, %387
  %395 = load i32* @out_before, align 4, !dbg !1109, !tbaa !778
  %396 = icmp slt i32 %395, 0, !dbg !1109
  br i1 %396, label %397, label %398, !dbg !1109

; <label>:397                                     ; preds = %394
  store i32 %112, i32* @out_before, align 4, !dbg !793, !tbaa !778
  br label %398, !dbg !793

; <label>:398                                     ; preds = %397, %394
  %399 = load i32* @color_option, align 4, !dbg !1110, !tbaa !778
  %400 = icmp eq i32 %399, 0, !dbg !1110
  br i1 %400, label %parse_grep_colors.exit, label %401, !dbg !1110

; <label>:401                                     ; preds = %398
  %402 = call i8* @getenv(i8* getelementptr inbounds ([11 x i8]* @.str50, i64 0, i64 0)) #8, !dbg !1111
  call void @llvm.dbg.value(metadata !{i8* %402}, i64 0, metadata !192), !dbg !1111
  %403 = icmp eq i8* %402, null, !dbg !1112
  br i1 %403, label %408, label %404, !dbg !1112

; <label>:404                                     ; preds = %401
  %405 = load i8* %402, align 1, !dbg !1112, !tbaa !773
  %406 = icmp eq i8 %405, 0, !dbg !1112
  br i1 %406, label %408, label %407, !dbg !1112

; <label>:407                                     ; preds = %404
  store i8* %402, i8** @context_match_color, align 8, !dbg !1114, !tbaa !717
  store i8* %402, i8** @selected_match_color, align 8, !dbg !1114, !tbaa !717
  br label %408, !dbg !1114

; <label>:408                                     ; preds = %404, %401, %407
  %409 = call i8* @getenv(i8* getelementptr inbounds ([12 x i8]* @.str70, i64 0, i64 0)) #8, !dbg !1115
  call void @llvm.dbg.value(metadata !{i8* %409}, i64 0, metadata !1117) #8, !dbg !1115
  %410 = icmp eq i8* %409, null, !dbg !1118
  br i1 %410, label %parse_grep_colors.exit, label %411, !dbg !1118

; <label>:411                                     ; preds = %408
  %412 = load i8* %409, align 1, !dbg !1118, !tbaa !773
  %413 = icmp eq i8 %412, 0, !dbg !1118
  br i1 %413, label %parse_grep_colors.exit, label %414, !dbg !1118

; <label>:414                                     ; preds = %411
  %415 = call i64 @strlen(i8* %409) #12, !dbg !1120
  %416 = add i64 %415, 1, !dbg !1120
  %417 = call noalias i8* @xmalloc(i64 %416) #8, !dbg !1120
  call void @llvm.dbg.value(metadata !{i8* %417}, i64 0, metadata !1121) #8, !dbg !1120
  %418 = icmp eq i8* %417, null, !dbg !1122
  br i1 %418, label %parse_grep_colors.exit, label %419, !dbg !1122

; <label>:419                                     ; preds = %414
  %420 = call i8* @strcpy(i8* %417, i8* %409) #8, !dbg !1124
  call void @llvm.dbg.value(metadata !{i8* %417}, i64 0, metadata !1125) #8, !dbg !1126
  call void @llvm.dbg.value(metadata !767, i64 0, metadata !1127) #8, !dbg !1128
  br label %.outer.outer.i, !dbg !1129

.outer.outer.i:                                   ; preds = %459, %419
  %name.0.ph.ph.i = phi i8* [ %417, %419 ], [ %425, %459 ]
  br label %.outer.i

.outer.i:                                         ; preds = %467, %464, %.outer.outer.i
  %val.0.ph.i = phi i8* [ null, %.outer.outer.i ], [ %465, %464 ], [ null, %467 ]
  %q.0.ph.i = phi i8* [ %name.0.ph.ph.i, %.outer.outer.i ], [ %465, %464 ], [ %468, %467 ]
  %421 = icmp eq i8* %val.0.ph.i, null, !dbg !1130
  br label %422

; <label>:422                                     ; preds = %469, %.outer.i
  %q.0.i = phi i8* [ %472, %469 ], [ %q.0.ph.i, %.outer.i ]
  %423 = load i8* %q.0.i, align 1, !dbg !1133, !tbaa !773
  switch i8 %423, label %466 [
    i8 58, label %424
    i8 0, label %424
    i8 61, label %461
  ], !dbg !1133

; <label>:424                                     ; preds = %422, %422
  call void @llvm.dbg.value(metadata !{i8 %423}, i64 0, metadata !1134) #8, !dbg !1135
  %425 = getelementptr inbounds i8* %q.0.i, i64 1, !dbg !1136
  call void @llvm.dbg.value(metadata !{i8* %425}, i64 0, metadata !1121) #8, !dbg !1136
  store i8 0, i8* %q.0.i, align 1, !dbg !1136, !tbaa !773
  call void @llvm.dbg.value(metadata !1137, i64 0, metadata !1138) #8, !dbg !1139
  br label %429, !dbg !1139

; <label>:426                                     ; preds = %429
  %427 = load i8** %434, align 8, !dbg !1139, !tbaa !1140
  %428 = icmp eq i8* %427, null, !dbg !1139
  br i1 %428, label %.thread.i95.loopexit, label %429, !dbg !1139

; <label>:429                                     ; preds = %426, %424
  %430 = phi i8* [ getelementptr inbounds ([3 x i8]* @.str75, i64 0, i64 0), %424 ], [ %427, %426 ]
  %431 = phi i8** [ getelementptr inbounds ([12 x %struct.color_cap]* @color_dict, i64 0, i64 0, i32 0), %424 ], [ %434, %426 ]
  %432 = call i32 @strcmp(i8* %430, i8* %name.0.ph.ph.i) #8, !dbg !1142
  %433 = icmp eq i32 %432, 0, !dbg !1142
  %434 = getelementptr inbounds i8** %431, i64 3, !dbg !1139
  br i1 %433, label %435, label %426, !dbg !1142

; <label>:435                                     ; preds = %429
  %indvars.i = bitcast i8** %431 to %struct.color_cap*
  %.pr.i = load i8** %431, align 8, !dbg !1143, !tbaa !1140
  %436 = icmp eq i8* %.pr.i, null, !dbg !1143
  br i1 %436, label %.thread.i95, label %437, !dbg !1143

; <label>:437                                     ; preds = %435
  %438 = getelementptr inbounds i8** %431, i64 1, !dbg !1145
  %439 = load i8** %438, align 8, !dbg !1145
  %440 = bitcast i8* %439 to i8**, !dbg !1145
  %441 = icmp eq i8* %439, null, !dbg !1145
  %442 = icmp ne i8* %val.0.ph.i, null, !dbg !1148
  br i1 %441, label %447, label %443, !dbg !1145

; <label>:443                                     ; preds = %437
  br i1 %442, label %444, label %445, !dbg !1148

; <label>:444                                     ; preds = %443
  store i8* %val.0.ph.i, i8** %440, align 8, !dbg !1151, !tbaa !717
  br label %.thread.i95, !dbg !1151

; <label>:445                                     ; preds = %443
  %446 = call i8* @dcgettext(i8* null, i8* getelementptr inbounds ([71 x i8]* @.str71, i64 0, i64 0), i32 5) #8, !dbg !1152
  call void (i32, i32, i8*, ...)* @error(i32 0, i32 0, i8* %446, i8* %409, i8* %name.0.ph.ph.i) #8, !dbg !1152
  br label %.thread.i95

; <label>:447                                     ; preds = %437
  br i1 %442, label %448, label %.thread.i95, !dbg !1153

; <label>:448                                     ; preds = %447
  %449 = call i8* @dcgettext(i8* null, i8* getelementptr inbounds ([91 x i8]* @.str72, i64 0, i64 0), i32 5) #8, !dbg !1155
  call void (i32, i32, i8*, ...)* @error(i32 0, i32 0, i8* %449, i8* %409, i8* %name.0.ph.ph.i, i8* %val.0.ph.i) #8, !dbg !1155
  br label %.thread.i95, !dbg !1155

.thread.i95.loopexit:                             ; preds = %426
  %450 = bitcast i8** %434 to %struct.color_cap*, !dbg !1139
  br label %.thread.i95

.thread.i95:                                      ; preds = %.thread.i95.loopexit, %448, %447, %445, %444, %435
  %cap.017.i = phi %struct.color_cap* [ %indvars.i, %435 ], [ %indvars.i, %445 ], [ %indvars.i, %444 ], [ %indvars.i, %448 ], [ %indvars.i, %447 ], [ %450, %.thread.i95.loopexit ]
  %451 = getelementptr inbounds %struct.color_cap* %cap.017.i, i64 0, i32 2, !dbg !1156
  %452 = load i8* ()** %451, align 8, !dbg !1156, !tbaa !1157
  %453 = icmp eq i8* ()* %452, null, !dbg !1156
  br i1 %453, label %459, label %454, !dbg !1156

; <label>:454                                     ; preds = %.thread.i95
  %455 = call i8* %452() #8, !dbg !1158
  call void @llvm.dbg.value(metadata !{i8* %455}, i64 0, metadata !1159) #8, !dbg !1158
  %456 = icmp eq i8* %455, null, !dbg !1160
  br i1 %456, label %459, label %457, !dbg !1160

; <label>:457                                     ; preds = %454
  %458 = call i8* @dcgettext(i8* null, i8* getelementptr inbounds ([42 x i8]* @.str73, i64 0, i64 0), i32 5) #8, !dbg !1162
  call void (i32, i32, i8*, ...)* @error(i32 0, i32 0, i8* %458, i8* %409, i8* %name.0.ph.ph.i, i8* %455) #8, !dbg !1162
  br label %459, !dbg !1162

; <label>:459                                     ; preds = %457, %454, %.thread.i95
  %460 = icmp eq i8 %423, 0, !dbg !1163
  br i1 %460, label %parse_grep_colors.exit, label %.outer.outer.i, !dbg !1163

; <label>:461                                     ; preds = %422
  %462 = icmp eq i8* %q.0.i, %name.0.ph.ph.i, !dbg !1165
  %463 = icmp ne i8* %val.0.ph.i, null, !dbg !1165
  %or.cond.i96 = or i1 %462, %463, !dbg !1165
  br i1 %or.cond.i96, label %.loopexit5.i, label %464, !dbg !1165

; <label>:464                                     ; preds = %461
  %465 = getelementptr inbounds i8* %q.0.i, i64 1, !dbg !1168
  call void @llvm.dbg.value(metadata !{i8* %465}, i64 0, metadata !1121) #8, !dbg !1168
  store i8 0, i8* %q.0.i, align 1, !dbg !1168, !tbaa !773
  call void @llvm.dbg.value(metadata !{i8* %465}, i64 0, metadata !1127) #8, !dbg !1169
  br label %.outer.i, !dbg !1170

; <label>:466                                     ; preds = %422
  br i1 %421, label %467, label %469, !dbg !1130

; <label>:467                                     ; preds = %466
  %468 = getelementptr inbounds i8* %q.0.i, i64 1, !dbg !1171
  call void @llvm.dbg.value(metadata !{i8* %468}, i64 0, metadata !1121) #8, !dbg !1171
  br label %.outer.i, !dbg !1171

; <label>:469                                     ; preds = %466
  %470 = icmp eq i8 %423, 59, !dbg !1172
  %.off.i97 = add i8 %423, -48, !dbg !1172
  %471 = icmp ult i8 %.off.i97, 10, !dbg !1172
  %or.cond4.i = or i1 %470, %471, !dbg !1172
  %472 = getelementptr inbounds i8* %q.0.i, i64 1, !dbg !1174
  call void @llvm.dbg.value(metadata !{i8* %472}, i64 0, metadata !1121) #8, !dbg !1174
  br i1 %or.cond4.i, label %422, label %.loopexit5.i, !dbg !1172

.loopexit5.i:                                     ; preds = %461, %469
  %473 = call i8* @dcgettext(i8* null, i8* getelementptr inbounds ([78 x i8]* @.str74, i64 0, i64 0), i32 5) #8, !dbg !1175
  call void (i32, i32, i8*, ...)* @error(i32 0, i32 0, i8* %473, i8* %409, i8* %q.0.i) #8, !dbg !1175
  br label %parse_grep_colors.exit, !dbg !1176

parse_grep_colors.exit:                           ; preds = %459, %.loopexit5.i, %414, %411, %408, %398
  %474 = icmp eq i32 %78, 0, !dbg !1177
  br i1 %474, label %480, label %475, !dbg !1177

; <label>:475                                     ; preds = %parse_grep_colors.exit
  %476 = load %struct._IO_FILE** @stdout, align 8, !dbg !1179, !tbaa !717
  %477 = load i8** @program_name, align 8, !dbg !1179, !tbaa !717
  %478 = call i8* @proper_name(i8* getelementptr inbounds ([13 x i8]* @.str53, i64 0, i64 0)) #8, !dbg !1179
  %479 = call i8* @dcgettext(i8* null, i8* getelementptr inbounds ([63 x i8]* @.str54, i64 0, i64 0), i32 5) #8, !dbg !1179
  call void (%struct._IO_FILE*, i8*, i8*, i8*, ...)* @version_etc(%struct._IO_FILE* %476, i8* %477, i8* getelementptr inbounds ([9 x i8]* @.str51, i64 0, i64 0), i8* getelementptr inbounds ([4 x i8]* @.str52, i64 0, i64 0), i8* %478, i8* %479, i8* null) #8, !dbg !1179
  call void @exit(i32 0) #11, !dbg !1181
  unreachable, !dbg !1181

; <label>:480                                     ; preds = %parse_grep_colors.exit
  %481 = load i32* @show_help, align 4, !dbg !1182, !tbaa !778
  %482 = icmp eq i32 %481, 0, !dbg !1182
  br i1 %482, label %484, label %483, !dbg !1182

; <label>:483                                     ; preds = %480
  call void @usage(i32 0) #13, !dbg !1184
  unreachable, !dbg !1184

; <label>:484                                     ; preds = %480
  %485 = icmp eq i8* %keys.0, null, !dbg !1185
  br i1 %485, label %493, label %486, !dbg !1185

; <label>:486                                     ; preds = %484
  %487 = icmp eq i64 %keycc.0, 0, !dbg !1186
  br i1 %487, label %488, label %491, !dbg !1186

; <label>:488                                     ; preds = %486
  %489 = load i32* @out_invert, align 4, !dbg !1189, !tbaa !778
  %490 = xor i32 %489, 1, !dbg !1189
  store i32 %490, i32* @out_invert, align 4, !dbg !1189, !tbaa !778
  store i32 0, i32* @match_words, align 4, !dbg !1191, !tbaa !778
  store i32 0, i32* @match_lines, align 4, !dbg !1191, !tbaa !778
  br label %510, !dbg !1192

; <label>:491                                     ; preds = %486
  %492 = add i64 %keycc.0, -1, !dbg !1193
  call void @llvm.dbg.value(metadata !{i64 %492}, i64 0, metadata !64), !dbg !1193
  br label %510

; <label>:493                                     ; preds = %484
  %494 = load i32* @optind, align 4, !dbg !753, !tbaa !778
  %495 = icmp slt i32 %494, %argc99, !dbg !753
  br i1 %495, label %496, label %509, !dbg !753

; <label>:496                                     ; preds = %493
  %497 = sext i32 %494 to i64, !dbg !762
  %498 = getelementptr inbounds i8** %argv98, i64 %497, !dbg !762
  %499 = load i8** %498, align 8, !dbg !762, !tbaa !717
  %500 = call i64 @strlen(i8* %499) #12, !dbg !762
  call void @llvm.dbg.value(metadata !{i64 %500}, i64 0, metadata !64), !dbg !762
  %501 = add i64 %500, 1, !dbg !1194
  %502 = call noalias i8* @xmalloc(i64 %501) #8, !dbg !1194
  call void @llvm.dbg.value(metadata !{i8* %502}, i64 0, metadata !63), !dbg !1194
  %503 = load i32* @optind, align 4, !dbg !764, !tbaa !778
  %504 = add nsw i32 %503, 1, !dbg !764
  store i32 %504, i32* @optind, align 4, !dbg !764, !tbaa !778
  %505 = sext i32 %503 to i64, !dbg !764
  %506 = getelementptr inbounds i8** %argv98, i64 %505, !dbg !764
  %507 = load i8** %506, align 8, !dbg !764, !tbaa !717
  %508 = call i8* @strcpy(i8* %502, i8* %507) #8, !dbg !764
  br label %510

; <label>:509                                     ; preds = %493
  call void @usage(i32 2) #13, !dbg !1195
  unreachable, !dbg !1195

; <label>:510                                     ; preds = %488, %491, %496
  %keycc.2 = phi i64 [ 0, %488 ], [ %492, %491 ], [ %500, %496 ]
  %keys.2 = phi i8* [ %keys.0, %488 ], [ %keys.0, %491 ], [ %502, %496 ]
  %511 = load void (i8*, i64)** @compile, align 8, !dbg !1196, !tbaa !717
  call void %511(i8* %keys.2, i64 %keycc.2) #8, !dbg !1196
  call void @free(i8* %keys.2) #8, !dbg !1197
  %512 = load i32* @optind, align 4, !dbg !756, !tbaa !778
  %513 = sub nsw i32 %argc99, %512, !dbg !756
  %514 = icmp slt i32 %513, 2, !dbg !756
  %.b = load i1* @no_filenames, align 1
  %or.cond71 = or i1 %514, %.b, !dbg !756
  %or.cond71.not = xor i1 %or.cond71, true, !dbg !756
  %515 = icmp ne i32 %with_filenames.0, 0, !dbg !756
  %or.cond73 = or i1 %515, %or.cond71.not, !dbg !756
  br i1 %or.cond73, label %516, label %517, !dbg !756

; <label>:516                                     ; preds = %510
  store i32 1, i32* @out_file, align 4, !dbg !1198, !tbaa !778
  br label %517, !dbg !1198

; <label>:517                                     ; preds = %510, %516
  %518 = call i32 @isatty(i32 1) #8, !dbg !1199
  %519 = load i64* @max_count, align 8, !dbg !1201, !tbaa !775
  %520 = icmp eq i64 %519, 0, !dbg !1201
  br i1 %520, label %521, label %522, !dbg !1201

; <label>:521                                     ; preds = %517
  call void @exit(i32 1) #11, !dbg !1203
  unreachable, !dbg !1203

; <label>:522                                     ; preds = %517
  %523 = load i32* @optind, align 4, !dbg !758, !tbaa !778
  %524 = icmp slt i32 %523, %argc99, !dbg !758
  br i1 %524, label %.preheader, label %564, !dbg !758

.preheader:                                       ; preds = %522, %560
  %525 = phi i32 [ %562, %560 ], [ %523, %522 ]
  %status.0 = phi i32 [ %status.1, %560 ], [ 1, %522 ]
  %526 = sext i32 %525 to i64, !dbg !765
  %527 = getelementptr inbounds i8** %argv98, i64 %526, !dbg !765
  %528 = load i8** %527, align 8, !dbg !765, !tbaa !717
  call void @llvm.dbg.value(metadata !{i8* %528}, i64 0, metadata !195), !dbg !765
  %529 = load %struct.exclude** @included_patterns, align 8, !dbg !1204, !tbaa !717
  %530 = icmp ne %struct.exclude* %529, null, !dbg !1204
  %531 = load %struct.exclude** @excluded_patterns, align 8, !dbg !1204, !tbaa !717
  %532 = icmp ne %struct.exclude* %531, null, !dbg !1204
  %or.cond75 = or i1 %530, %532, !dbg !1204
  br i1 %or.cond75, label %533, label %546, !dbg !1204

; <label>:533                                     ; preds = %.preheader
  %534 = call i32 @isdir(i8* %528) #8, !dbg !1206
  %535 = icmp eq i32 %534, 0, !dbg !1206
  br i1 %535, label %536, label %546, !dbg !1206

; <label>:536                                     ; preds = %533
  %537 = load %struct.exclude** @included_patterns, align 8, !dbg !1207, !tbaa !717
  %538 = icmp eq %struct.exclude* %537, null, !dbg !1207
  br i1 %538, label %541, label %539, !dbg !1207

; <label>:539                                     ; preds = %536
  %540 = call zeroext i1 @excluded_file_name(%struct.exclude* %537, i8* %528) #8, !dbg !1210
  br i1 %540, label %560, label %541, !dbg !1210

; <label>:541                                     ; preds = %536, %539
  %542 = load %struct.exclude** @excluded_patterns, align 8, !dbg !1211, !tbaa !717
  %543 = icmp eq %struct.exclude* %542, null, !dbg !1211
  br i1 %543, label %546, label %544, !dbg !1211

; <label>:544                                     ; preds = %541
  %545 = call zeroext i1 @excluded_file_name(%struct.exclude* %542, i8* %528) #8, !dbg !1213
  br i1 %545, label %560, label %546, !dbg !1213

; <label>:546                                     ; preds = %541, %533, %544, %.preheader
  call void @llvm.dbg.value(metadata !969, i64 0, metadata !201), !dbg !1214
  call void @llvm.dbg.value(metadata !{i8* %528}, i64 0, metadata !202), !dbg !1215
  %547 = load i8* %528, align 1, !dbg !1215, !tbaa !773
  %548 = zext i8 %547 to i32, !dbg !1215
  %549 = add nsw i32 %548, -45, !dbg !1215
  call void @llvm.dbg.value(metadata !{i32 %549}, i64 0, metadata !204), !dbg !1215
  %550 = icmp eq i32 %549, 0, !dbg !1216
  br i1 %550, label %551, label %555, !dbg !1216

; <label>:551                                     ; preds = %546
  %552 = getelementptr inbounds i8* %528, i64 1, !dbg !1218
  %553 = load i8* %552, align 1, !dbg !1218, !tbaa !773
  %554 = zext i8 %553 to i32, !dbg !1218
  call void @llvm.dbg.value(metadata !{i32 %554}, i64 0, metadata !204), !dbg !1218
  br label %555, !dbg !1220

; <label>:555                                     ; preds = %546, %551
  %__result28.0 = phi i32 [ %554, %551 ], [ %549, %546 ]
  %556 = icmp eq i32 %__result28.0, 0, !dbg !1214
  %557 = select i1 %556, i8* null, i8* %528, !dbg !1214
  %558 = call fastcc i32 @grepfile(i8* %557, %struct.stats* @stats_base), !dbg !1222
  %559 = and i32 %558, %status.0, !dbg !1222
  call void @llvm.dbg.value(metadata !{i32 %559}, i64 0, metadata !73), !dbg !1222
  br label %560, !dbg !759

; <label>:560                                     ; preds = %544, %539, %555
  %status.1 = phi i32 [ %559, %555 ], [ %status.0, %539 ], [ %status.0, %544 ]
  %561 = load i32* @optind, align 4, !dbg !759, !tbaa !778
  %562 = add nsw i32 %561, 1, !dbg !759
  store i32 %562, i32* @optind, align 4, !dbg !759, !tbaa !778
  %563 = icmp slt i32 %562, %argc99, !dbg !759
  br i1 %563, label %.preheader, label %.loopexit, !dbg !759

; <label>:564                                     ; preds = %522
  %565 = call fastcc i32 @grepfile(i8* null, %struct.stats* @stats_base), !dbg !1223
  call void @llvm.dbg.value(metadata !{i32 %565}, i64 0, metadata !73), !dbg !1223
  br label %.loopexit

.loopexit:                                        ; preds = %560, %564
  %status.2 = phi i32 [ %565, %564 ], [ %status.1, %560 ]
  %.b85 = load i1* @errseen, align 1
  %566 = select i1 %.b85, i32 2, i32 %status.2, !dbg !1224
  call void @exit(i32 %566) #11, !dbg !1224
  unreachable, !dbg !1224
}

declare void @set_program_name(i8*) #3

; Function Attrs: nounwind
declare i8* @setlocale(i32, i8*) #2

; Function Attrs: nounwind
declare i8* @bindtextdomain(i8*, i8*) #2

; Function Attrs: nounwind
declare i8* @textdomain(i8*) #2

; Function Attrs: nounwind
declare i32 @atexit(void ()*) #2

declare void @close_stdout() #3

; Function Attrs: nounwind readonly
declare i8* @getenv(i8* nocapture) #5

; Function Attrs: nounwind uwtable
define internal fastcc void @setmatcher(i8* %m) #6 {
  tail call void @llvm.dbg.value(metadata !{i8* %m}, i64 0, metadata !559), !dbg !1225
  %1 = icmp eq i8* %m, null, !dbg !1226
  br i1 %1, label %2, label %9, !dbg !1226

; <label>:2                                       ; preds = %0
  %3 = load void (i8*, i64)** getelementptr inbounds ([0 x %struct.matcher]* @matchers, i64 0, i64 0, i32 1), align 8, !dbg !1227, !tbaa !864
  store void (i8*, i64)* %3, void (i8*, i64)** @compile, align 8, !dbg !1227, !tbaa !717
  %4 = load i64 (i8*, i64, i64*, i8*)** getelementptr inbounds ([0 x %struct.matcher]* @matchers, i64 0, i64 0, i32 2), align 8, !dbg !1228, !tbaa !866
  store i64 (i8*, i64, i64*, i8*)* %4, i64 (i8*, i64, i64*, i8*)** @execute, align 8, !dbg !1228, !tbaa !717
  %5 = load i8** getelementptr inbounds ([0 x %struct.matcher]* @matchers, i64 0, i64 1, i32 0), align 8, !dbg !1229, !tbaa !730
  %6 = icmp eq i8* %5, null, !dbg !1229
  br i1 %6, label %7, label %42, !dbg !1229

; <label>:7                                       ; preds = %2
  %8 = load i8** getelementptr inbounds ([0 x %struct.matcher]* @matchers, i64 0, i64 0, i32 0), align 8, !dbg !1230, !tbaa !730
  store i8* %8, i8** @setmatcher.matcher, align 8, !dbg !1230, !tbaa !717
  br label %42, !dbg !1230

; <label>:9                                       ; preds = %0
  %10 = load i8** @setmatcher.matcher, align 8, !dbg !1231, !tbaa !717
  %11 = icmp eq i8* %10, null, !dbg !1231
  br i1 %11, label %.preheader, label %14, !dbg !1231

.preheader:                                       ; preds = %9
  %12 = load i8** getelementptr inbounds ([0 x %struct.matcher]* @matchers, i64 0, i64 0, i32 0), align 8, !dbg !1232, !tbaa !730
  %13 = icmp eq i8* %12, null, !dbg !1232
  br i1 %13, label %._crit_edge, label %.lr.ph, !dbg !1232

; <label>:14                                      ; preds = %9
  %15 = tail call i32 @strcmp(i8* %10, i8* %m) #8, !dbg !1233
  %16 = icmp eq i32 %15, 0, !dbg !1233
  br i1 %16, label %42, label %17, !dbg !1233

; <label>:17                                      ; preds = %14
  %18 = load i8** getelementptr inbounds ([0 x %struct.matcher]* @matchers, i64 0, i64 1, i32 0), align 8, !dbg !1234, !tbaa !730
  %19 = icmp eq i8* %18, null, !dbg !1234
  br i1 %19, label %20, label %24, !dbg !1234

; <label>:20                                      ; preds = %17
  %21 = tail call i8* @dcgettext(i8* null, i8* getelementptr inbounds ([38 x i8]* @.str141, i64 0, i64 0), i32 5) #8, !dbg !1236
  %22 = load i8** @program_name, align 8, !dbg !1236, !tbaa !717
  %23 = load i8** @setmatcher.matcher, align 8, !dbg !1236, !tbaa !717
  tail call void (i32, i32, i8*, ...)* @error(i32 2, i32 0, i8* %21, i8* %22, i8* %23) #8, !dbg !1236
  br label %42, !dbg !1236

; <label>:24                                      ; preds = %17
  %25 = tail call i8* @dcgettext(i8* null, i8* getelementptr inbounds ([31 x i8]* @.str142, i64 0, i64 0), i32 5) #8, !dbg !1237
  tail call void (i32, i32, i8*, ...)* @error(i32 2, i32 0, i8* %25) #8, !dbg !1237
  br label %42

; <label>:26                                      ; preds = %.lr.ph
  %27 = zext i32 %35 to i64, !dbg !1232
  %28 = getelementptr inbounds [0 x %struct.matcher]* @matchers, i64 0, i64 %27, i32 0, !dbg !1232
  %29 = load i8** %28, align 8, !dbg !1232, !tbaa !730
  %30 = icmp eq i8* %29, null, !dbg !1232
  br i1 %30, label %._crit_edge, label %.lr.ph, !dbg !1232

.lr.ph:                                           ; preds = %.preheader, %26
  %31 = phi i8* [ %29, %26 ], [ %12, %.preheader ]
  %32 = phi i64 [ %27, %26 ], [ 0, %.preheader ]
  %i.04 = phi i32 [ %35, %26 ], [ 0, %.preheader ]
  %33 = tail call i32 @strcmp(i8* %m, i8* %31) #8, !dbg !1238
  %34 = icmp eq i32 %33, 0, !dbg !1238
  %35 = add i32 %i.04, 1, !dbg !1232
  tail call void @llvm.dbg.value(metadata !{i32 %35}, i64 0, metadata !560), !dbg !1232
  br i1 %34, label %36, label %26, !dbg !1238

; <label>:36                                      ; preds = %.lr.ph
  %37 = getelementptr inbounds [0 x %struct.matcher]* @matchers, i64 0, i64 %32, i32 1, !dbg !1239
  %38 = load void (i8*, i64)** %37, align 8, !dbg !1239, !tbaa !864
  store void (i8*, i64)* %38, void (i8*, i64)** @compile, align 8, !dbg !1239, !tbaa !717
  %39 = getelementptr inbounds [0 x %struct.matcher]* @matchers, i64 0, i64 %32, i32 2, !dbg !1241
  %40 = load i64 (i8*, i64, i64*, i8*)** %39, align 8, !dbg !1241, !tbaa !866
  store i64 (i8*, i64, i64*, i8*)* %40, i64 (i8*, i64, i64*, i8*)** @execute, align 8, !dbg !1241, !tbaa !717
  store i8* %m, i8** @setmatcher.matcher, align 8, !dbg !1242, !tbaa !717
  br label %42, !dbg !1243

._crit_edge:                                      ; preds = %26, %.preheader
  %41 = tail call i8* @dcgettext(i8* null, i8* getelementptr inbounds ([19 x i8]* @.str143, i64 0, i64 0), i32 5) #8, !dbg !1244
  tail call void (i32, i32, i8*, ...)* @error(i32 2, i32 0, i8* %41, i8* %m) #8, !dbg !1244
  br label %42

; <label>:42                                      ; preds = %2, %._crit_edge, %20, %24, %14, %7, %36
  ret void, !dbg !1245
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8* nocapture, i8* nocapture) #5

declare void @error(i32, i32, i8*, ...) #3

declare i64 @__xargmatch_internal(i8*, i8*, i8**, i8*, i64, void ()*) #3

; Function Attrs: nounwind readonly
declare i64 @strlen(i8* nocapture) #5

declare i8* @xrealloc(i8*, i64) #3

; Function Attrs: nounwind
declare i8* @strcpy(i8*, i8* nocapture readonly) #2

; Function Attrs: nounwind
declare noalias %struct._IO_FILE* @fopen(i8* nocapture readonly, i8* nocapture readonly) #2

; Function Attrs: nounwind readnone
declare i32* @__errno_location() #7

declare i64 @fread_unlocked(i8*, i64, i64, %struct._IO_FILE*) #3

; Function Attrs: nounwind
declare i32 @fclose(%struct._IO_FILE* nocapture) #2

declare i32 @xstrtoumax(i8*, i8**, i32, i64*, i8*) #3

; Function Attrs: nounwind readonly
declare i32 @strcasecmp(i8* nocapture, i8* nocapture) #5

; Function Attrs: nounwind
declare i32 @isatty(i32) #2

declare %struct.exclude* @new_exclude() #3

declare void @add_exclude(%struct.exclude*, i8*, i32) #3

declare i32 @add_exclude_file(void (%struct.exclude*, i8*, i32)*, %struct.exclude*, i8*, i32, i8 signext) #3

declare void @version_etc(%struct._IO_FILE*, i8*, i8*, i8*, ...) #3

declare i8* @proper_name(i8*) #3

declare noalias i8* @xmalloc(i64) #3

; Function Attrs: nounwind
declare void @free(i8* nocapture) #2

declare i32 @isdir(i8*) #3

declare zeroext i1 @excluded_file_name(%struct.exclude*, i8*) #3

; Function Attrs: nounwind uwtable
define internal fastcc i32 @grepfile(i8* %file, %struct.stats* %stats) #6 {
  tail call void @llvm.dbg.value(metadata !{i8* %file}, i64 0, metadata !252), !dbg !1246
  tail call void @llvm.dbg.value(metadata !{%struct.stats* %stats}, i64 0, metadata !253), !dbg !1246
  %1 = icmp ne i8* %file, null, !dbg !1247
  br i1 %1, label %7, label %2, !dbg !1247

; <label>:2                                       ; preds = %0
  tail call void @llvm.dbg.value(metadata !45, i64 0, metadata !254), !dbg !1248
  %3 = load i8** @label, align 8, !dbg !1250, !tbaa !717
  %4 = icmp eq i8* %3, null, !dbg !1250
  br i1 %4, label %5, label %.critedge8, !dbg !1250

; <label>:5                                       ; preds = %2
  %6 = tail call i8* @dcgettext(i8* null, i8* getelementptr inbounds ([17 x i8]* @.str55, i64 0, i64 0), i32 5) #8, !dbg !1250
  br label %.critedge8, !dbg !1250

; <label>:7                                       ; preds = %0
  %8 = getelementptr inbounds %struct.stats* %stats, i64 0, i32 1, !dbg !1251
  tail call void @llvm.dbg.value(metadata !{i8* %file}, i64 0, metadata !1253) #8, !dbg !1254
  tail call void @llvm.dbg.value(metadata !{%struct.stat* %8}, i64 0, metadata !1255) #8, !dbg !1254
  %9 = tail call i32 @__xstat(i32 1, i8* %file, %struct.stat* %8) #8, !dbg !1256
  %10 = icmp eq i32 %9, 0, !dbg !1251
  br i1 %10, label %15, label %11, !dbg !1251

; <label>:11                                      ; preds = %7
  tail call void @llvm.dbg.value(metadata !{i8* %file}, i64 0, metadata !1258) #8, !dbg !1261
  tail call void @llvm.dbg.value(metadata !{i32 %14}, i64 0, metadata !1262) #8, !dbg !1261
  %.b.i = load i1* @suppress_errors, align 1
  br i1 %.b.i, label %suppressible_error.exit, label %12, !dbg !1263

; <label>:12                                      ; preds = %11
  %13 = tail call i32* @__errno_location() #1, !dbg !1259
  %14 = load i32* %13, align 4, !dbg !1259, !tbaa !778
  tail call void (i32, i32, i8*, ...)* @error(i32 0, i32 %14, i8* getelementptr inbounds ([3 x i8]* @.str3, i64 0, i64 0), i8* %file) #8, !dbg !1265
  br label %suppressible_error.exit, !dbg !1265

suppressible_error.exit:                          ; preds = %11, %12
  store i1 true, i1* @errseen, align 1
  br label %.loopexit, !dbg !1266

; <label>:15                                      ; preds = %7
  %16 = load i32* @directories, align 4, !dbg !1267, !tbaa !773
  %17 = icmp eq i32 %16, 4, !dbg !1267
  br i1 %17, label %18, label %23, !dbg !1267

; <label>:18                                      ; preds = %15
  %19 = getelementptr inbounds %struct.stats* %stats, i64 0, i32 1, i32 3, !dbg !1267
  %20 = load i32* %19, align 4, !dbg !1267, !tbaa !1269
  %21 = and i32 %20, 61440, !dbg !1267
  %22 = icmp eq i32 %21, 16384, !dbg !1267
  br i1 %22, label %.loopexit, label %23, !dbg !1267

; <label>:23                                      ; preds = %18, %15
  %.b5 = load i1* @devices, align 1
  br i1 %.b5, label %24, label %.preheader22, !dbg !1273

; <label>:24                                      ; preds = %23
  %25 = getelementptr inbounds %struct.stats* %stats, i64 0, i32 1, i32 3, !dbg !1273
  %26 = load i32* %25, align 4, !dbg !1273, !tbaa !1269
  %27 = and i32 %26, 61440, !dbg !1273
  switch i32 %27, label %.preheader22 [
    i32 8192, label %.loopexit
    i32 24576, label %.loopexit
    i32 49152, label %.loopexit
    i32 4096, label %.loopexit
  ], !dbg !1273

.preheader22:                                     ; preds = %24, %23, %30
  %28 = tail call i32 (i8*, i32, ...)* @open(i8* %file, i32 0) #8, !dbg !1275
  tail call void @llvm.dbg.value(metadata !{i32 %28}, i64 0, metadata !254), !dbg !1275
  %29 = icmp slt i32 %28, 0, !dbg !1275
  br i1 %29, label %30, label %.critedge8, !dbg !1275

; <label>:30                                      ; preds = %.preheader22
  %31 = tail call i32* @__errno_location() #1, !dbg !1275
  %32 = load i32* %31, align 4, !dbg !1275, !tbaa !778
  %33 = icmp eq i32 %32, 4, !dbg !1275
  br i1 %33, label %.preheader22, label %34

; <label>:34                                      ; preds = %30
  tail call void @llvm.dbg.value(metadata !{i32 %32}, i64 0, metadata !257), !dbg !1276
  %35 = icmp eq i32 %32, 21, !dbg !1277
  %36 = load i32* @directories, align 4, !dbg !1277, !tbaa !773
  %37 = icmp eq i32 %36, 3, !dbg !1277
  %or.cond = and i1 %35, %37, !dbg !1277
  br i1 %or.cond, label %38, label %45, !dbg !1277

; <label>:38                                      ; preds = %34
  tail call void @llvm.dbg.value(metadata !{i8* %file}, i64 0, metadata !1279) #8, !dbg !1283
  tail call void @llvm.dbg.value(metadata !{%struct.stat* %8}, i64 0, metadata !1284) #8, !dbg !1283
  %39 = tail call i32 @__xstat(i32 1, i8* %file, %struct.stat* %8) #8, !dbg !1285
  %40 = icmp eq i32 %39, 0, !dbg !1280
  br i1 %40, label %43, label %41, !dbg !1280

; <label>:41                                      ; preds = %38
  %42 = load i32* %31, align 4, !dbg !1286, !tbaa !778
  tail call void (i32, i32, i8*, ...)* @error(i32 0, i32 %42, i8* getelementptr inbounds ([3 x i8]* @.str3, i64 0, i64 0), i8* %file) #8, !dbg !1286
  br label %.loopexit, !dbg !1288

; <label>:43                                      ; preds = %38
  %44 = tail call fastcc i32 @grepdir(i8* %file, %struct.stats* %stats), !dbg !1289
  br label %.loopexit, !dbg !1289

; <label>:45                                      ; preds = %34
  %.b7 = load i1* @suppress_errors, align 1
  %46 = xor i1 %.b7, true, !dbg !1290
  %47 = icmp eq i32 %36, 4, !dbg !1292
  %or.cond3 = and i1 %47, %46, !dbg !1290
  br i1 %or.cond3, label %48, label %52, !dbg !1290

; <label>:48                                      ; preds = %45
  switch i32 %32, label %thread-pre-split [
    i32 21, label %.loopexit
    i32 13, label %49
  ], !dbg !1295

; <label>:49                                      ; preds = %48
  %50 = tail call i32 @isdir(i8* %file) #8, !dbg !1296
  %51 = icmp eq i32 %50, 0, !dbg !1296
  br i1 %51, label %.thread-pre-split_crit_edge, label %.loopexit, !dbg !1296

.thread-pre-split_crit_edge:                      ; preds = %49
  %.b.i10.pr.pre = load i1* @suppress_errors, align 1
  tail call void @llvm.dbg.value(metadata !{i8* %file}, i64 0, metadata !1299) #8, !dbg !1301
  tail call void @llvm.dbg.value(metadata !{i32 %32}, i64 0, metadata !1302) #8, !dbg !1301
  br i1 %.b.i10.pr.pre, label %suppressible_error.exit11, label %53, !dbg !1303

thread-pre-split:                                 ; preds = %48
  tail call void @llvm.dbg.value(metadata !{i8* %file}, i64 0, metadata !1299) #8, !dbg !1301
  tail call void @llvm.dbg.value(metadata !{i32 %32}, i64 0, metadata !1302) #8, !dbg !1301
  br i1 %.b7, label %suppressible_error.exit11, label %53, !dbg !1303

; <label>:52                                      ; preds = %45
  tail call void @llvm.dbg.value(metadata !{i8* %file}, i64 0, metadata !1299) #8, !dbg !1301
  tail call void @llvm.dbg.value(metadata !{i32 %32}, i64 0, metadata !1302) #8, !dbg !1301
  br i1 %.b7, label %suppressible_error.exit11, label %53, !dbg !1303

; <label>:53                                      ; preds = %.thread-pre-split_crit_edge, %thread-pre-split, %52
  tail call void (i32, i32, i8*, ...)* @error(i32 0, i32 %32, i8* getelementptr inbounds ([3 x i8]* @.str3, i64 0, i64 0), i8* %file) #8, !dbg !1304
  br label %suppressible_error.exit11, !dbg !1304

suppressible_error.exit11:                        ; preds = %.thread-pre-split_crit_edge, %thread-pre-split, %52, %53
  store i1 true, i1* @errseen, align 1
  br label %.loopexit, !dbg !1305

.critedge8:                                       ; preds = %.preheader22, %5, %2
  %storemerge = phi i8* [ %6, %5 ], [ %3, %2 ], [ %file, %.preheader22 ]
  %desc.0 = phi i32 [ 0, %5 ], [ 0, %2 ], [ %28, %.preheader22 ]
  store i8* %storemerge, i8** @filename, align 8, !dbg !1306, !tbaa !717
  %54 = tail call i32 @isatty(i32 %desc.0) #8, !dbg !1307
  tail call void @llvm.dbg.value(metadata !{i32 %desc.0}, i64 0, metadata !1309) #8, !dbg !1311
  tail call void @llvm.dbg.value(metadata !{i8* %file}, i64 0, metadata !1312) #8, !dbg !1311
  tail call void @llvm.dbg.value(metadata !{%struct.stats* %stats}, i64 0, metadata !1313) #8, !dbg !1311
  %55 = load i8* @eolbyte, align 1, !dbg !1314, !tbaa !773
  tail call void @llvm.dbg.value(metadata !{i8 %55}, i64 0, metadata !1315) #8, !dbg !1314
  tail call void @llvm.dbg.value(metadata !{i32 %desc.0}, i64 0, metadata !1316) #8, !dbg !1319
  tail call void @llvm.dbg.value(metadata !{i8* %file}, i64 0, metadata !1320) #8, !dbg !1319
  tail call void @llvm.dbg.value(metadata !{%struct.stats* %stats}, i64 0, metadata !1321) #8, !dbg !1319
  %56 = load i64* @pagesize, align 8, !dbg !1322, !tbaa !775
  %57 = icmp eq i64 %56, 0, !dbg !1322
  br i1 %57, label %58, label %._crit_edge.i.i, !dbg !1322

._crit_edge.i.i:                                  ; preds = %.critedge8
  %.pre.i.i = load i8** @buffer, align 8, !dbg !1324, !tbaa !717
  br label %76, !dbg !1322

; <label>:58                                      ; preds = %.critedge8
  %59 = tail call i32 @getpagesize() #1, !dbg !1325
  %60 = sext i32 %59 to i64, !dbg !1325
  store i64 %60, i64* @pagesize, align 8, !dbg !1325, !tbaa !775
  %61 = icmp eq i32 %59, 0, !dbg !1327
  br i1 %61, label %66, label %62, !dbg !1327

; <label>:62                                      ; preds = %58
  %63 = shl nsw i64 %60, 1, !dbg !1327
  %64 = or i64 %63, 1, !dbg !1327
  %65 = icmp ugt i64 %64, %60, !dbg !1327
  br i1 %65, label %67, label %66, !dbg !1327

; <label>:66                                      ; preds = %62, %58
  tail call void @abort() #11, !dbg !1329
  unreachable, !dbg !1329

; <label>:67                                      ; preds = %62
  %68 = urem i64 32768, %60, !dbg !1330
  %69 = icmp eq i64 %68, 0, !dbg !1330
  br i1 %69, label %72, label %70, !dbg !1330

; <label>:70                                      ; preds = %67
  %71 = add i64 %60, 32769, !dbg !1330
  %phitmp.i.i = sub i64 %71, %68, !dbg !1330
  br label %72, !dbg !1330

; <label>:72                                      ; preds = %70, %67
  %73 = phi i64 [ %phitmp.i.i, %70 ], [ 32769, %67 ]
  %74 = add i64 %73, %60, !dbg !1330
  store i64 %74, i64* @bufalloc, align 8, !dbg !1330, !tbaa !775
  %75 = tail call noalias i8* @xmalloc(i64 %74) #8, !dbg !1331
  store i8* %75, i8** @buffer, align 8, !dbg !1331, !tbaa !717
  %.pre2.i.i = load i64* @pagesize, align 8, !dbg !1324, !tbaa !775
  br label %76, !dbg !1332

; <label>:76                                      ; preds = %72, %._crit_edge.i.i
  %77 = phi i64 [ %56, %._crit_edge.i.i ], [ %.pre2.i.i, %72 ]
  %78 = phi i8* [ %.pre.i.i, %._crit_edge.i.i ], [ %75, %72 ]
  %79 = getelementptr inbounds i8* %78, i64 1, !dbg !1324
  %80 = ptrtoint i8* %79 to i64, !dbg !1324
  %81 = urem i64 %80, %77, !dbg !1324
  %82 = icmp eq i64 %81, 0, !dbg !1324
  br i1 %82, label %86, label %83, !dbg !1324

; <label>:83                                      ; preds = %76
  %84 = add i64 %77, 1, !dbg !1324
  %.sum.i.i = sub i64 %84, %81, !dbg !1324
  %85 = getelementptr inbounds i8* %78, i64 %.sum.i.i, !dbg !1324
  br label %86, !dbg !1324

; <label>:86                                      ; preds = %83, %76
  %87 = phi i8* [ %85, %83 ], [ %79, %76 ], !dbg !1324
  store i8* %87, i8** @buflim, align 8, !dbg !1324, !tbaa !717
  store i8* %87, i8** @bufbeg, align 8, !dbg !1324, !tbaa !717
  %88 = load i8* @eolbyte, align 1, !dbg !1333, !tbaa !773
  %89 = getelementptr inbounds i8* %87, i64 -1, !dbg !1333
  store i8 %88, i8* %89, align 1, !dbg !1333, !tbaa !773
  store i32 %desc.0, i32* @bufdesc, align 4, !dbg !1334, !tbaa !778
  %90 = getelementptr inbounds %struct.stats* %stats, i64 0, i32 1, i32 3, !dbg !1335
  %91 = load i32* %90, align 4, !dbg !1335, !tbaa !1269
  %92 = and i32 %91, 61440, !dbg !1335
  %93 = icmp eq i32 %92, 32768, !dbg !1335
  br i1 %93, label %94, label %103, !dbg !1335

; <label>:94                                      ; preds = %86
  %95 = icmp eq i8* %file, null, !dbg !1337
  br i1 %95, label %97, label %96, !dbg !1337

; <label>:96                                      ; preds = %94
  store i64 0, i64* @bufoffset, align 8, !dbg !1340, !tbaa !775
  br label %103, !dbg !1340

; <label>:97                                      ; preds = %94
  %98 = tail call i64 @lseek(i32 %desc.0, i64 0, i32 1) #8, !dbg !1341
  store i64 %98, i64* @bufoffset, align 8, !dbg !1341, !tbaa !775
  %99 = icmp slt i64 %98, 0, !dbg !1343
  br i1 %99, label %reset.exit.i, label %103, !dbg !1343

reset.exit.i:                                     ; preds = %97
  %100 = tail call i32* @__errno_location() #1, !dbg !1345
  %101 = load i32* %100, align 4, !dbg !1345, !tbaa !778
  %102 = tail call i8* @dcgettext(i8* null, i8* getelementptr inbounds ([13 x i8]* @.str67, i64 0, i64 0), i32 5) #8, !dbg !1345
  tail call void (i32, i32, i8*, ...)* @error(i32 0, i32 %101, i8* %102) #8, !dbg !1345
  br label %grep.exit.thread, !dbg !1317

; <label>:103                                     ; preds = %96, %97, %86
  %104 = load i32* @directories, align 4, !dbg !1347, !tbaa !773
  %105 = icmp eq i32 %104, 3, !dbg !1347
  %or.cond.i = and i1 %1, %105, !dbg !1347
  br i1 %or.cond.i, label %106, label %119, !dbg !1347

; <label>:106                                     ; preds = %103
  %107 = load i32* %90, align 4, !dbg !1347, !tbaa !1269
  %108 = and i32 %107, 61440, !dbg !1347
  %109 = icmp eq i32 %108, 16384, !dbg !1347
  br i1 %109, label %110, label %119, !dbg !1347

; <label>:110                                     ; preds = %106
  %111 = tail call i32 @close(i32 %desc.0) #8, !dbg !1349
  %112 = icmp eq i32 %111, 0, !dbg !1349
  br i1 %112, label %116, label %113, !dbg !1349

; <label>:113                                     ; preds = %110
  %114 = tail call i32* @__errno_location() #1, !dbg !1352
  %115 = load i32* %114, align 4, !dbg !1352, !tbaa !778
  tail call void (i32, i32, i8*, ...)* @error(i32 0, i32 %115, i8* getelementptr inbounds ([3 x i8]* @.str3, i64 0, i64 0), i8* %file) #8, !dbg !1352
  br label %116, !dbg !1352

; <label>:116                                     ; preds = %113, %110
  %117 = tail call fastcc i32 @grepdir(i8* %file, %struct.stats* %stats) #8, !dbg !1353
  %118 = add nsw i32 %117, -2, !dbg !1353
  br label %grep.exit, !dbg !1353

; <label>:119                                     ; preds = %106, %103
  store i64 0, i64* @totalcc, align 8, !dbg !1354, !tbaa !775
  store i8* null, i8** @lastout, align 8, !dbg !1355, !tbaa !717
  store i64 0, i64* @totalnl, align 8, !dbg !1356, !tbaa !775
  %120 = load i64* @max_count, align 8, !dbg !1357, !tbaa !775
  store i64 %120, i64* @outleft, align 8, !dbg !1357, !tbaa !775
  store i64 0, i64* @after_last_match, align 8, !dbg !1358, !tbaa !775
  store i32 0, i32* @pending, align 4, !dbg !1359, !tbaa !778
  tail call void @llvm.dbg.value(metadata !45, i64 0, metadata !1360) #8, !dbg !1361
  tail call void @llvm.dbg.value(metadata !769, i64 0, metadata !1362) #8, !dbg !1363
  tail call void @llvm.dbg.value(metadata !769, i64 0, metadata !1364) #8, !dbg !1365
  %121 = tail call fastcc i32 @fillbuf(i64 0, %struct.stats* %stats) #8, !dbg !1366
  %122 = icmp eq i32 %121, 0, !dbg !1366
  br i1 %122, label %123, label %130, !dbg !1366

; <label>:123                                     ; preds = %119
  %124 = tail call i32* @__errno_location() #1, !dbg !1368
  %125 = load i32* %124, align 4, !dbg !1368, !tbaa !778
  %126 = icmp eq i32 %125, 21, !dbg !1368
  br i1 %126, label %grep.exit.thread, label %127, !dbg !1368

; <label>:127                                     ; preds = %123
  tail call void @llvm.dbg.value(metadata !{i8* %129}, i64 0, metadata !1371) #8, !dbg !1373
  tail call void @llvm.dbg.value(metadata !{i32 %125}, i64 0, metadata !1374) #8, !dbg !1373
  %.b.i.i = load i1* @suppress_errors, align 1
  br i1 %.b.i.i, label %suppressible_error.exit.i, label %128, !dbg !1375

; <label>:128                                     ; preds = %127
  %129 = load i8** @filename, align 8, !dbg !1372, !tbaa !717
  tail call void (i32, i32, i8*, ...)* @error(i32 0, i32 %125, i8* getelementptr inbounds ([3 x i8]* @.str3, i64 0, i64 0), i8* %129) #8, !dbg !1376
  br label %suppressible_error.exit.i, !dbg !1376

suppressible_error.exit.i:                        ; preds = %128, %127
  store i1 true, i1* @errseen, align 1
  br label %grep.exit.thread, !dbg !1372

; <label>:130                                     ; preds = %119
  %131 = load i32* @binary_files, align 4, !dbg !1377, !tbaa !773
  %132 = load i32* @out_quiet, align 4, !dbg !1377, !tbaa !778
  %133 = or i32 %132, %131, !dbg !1377
  %or.cond3.not.i = icmp eq i32 %133, 0, !dbg !1377
  %134 = icmp eq i32 %131, 2, !dbg !1377
  %or.cond5.i = or i1 %or.cond3.not.i, %134, !dbg !1377
  br i1 %or.cond5.i, label %135, label %.thread, !dbg !1377

; <label>:135                                     ; preds = %130
  %136 = load i8** @bufbeg, align 8, !dbg !1378, !tbaa !717
  %137 = icmp ne i8 %55, 0, !dbg !1378
  %138 = select i1 %137, i32 0, i32 -128, !dbg !1378
  %139 = load i8** @buflim, align 8, !dbg !1378, !tbaa !717
  %140 = ptrtoint i8* %139 to i64, !dbg !1378
  %141 = ptrtoint i8* %136 to i64, !dbg !1378
  %142 = sub i64 %140, %141, !dbg !1378
  %143 = tail call i8* @memchr(i8* %136, i32 %138, i64 %142) #12, !dbg !1378
  %144 = icmp ne i8* %143, null, !dbg !1378
  %145 = zext i1 %144 to i32
  tail call void @llvm.dbg.value(metadata !{i32 %146}, i64 0, metadata !1379) #8, !dbg !1380
  %or.cond7.i = and i1 %144, %134, !dbg !1381
  br i1 %or.cond7.i, label %grep.exit.thread, label %.thread, !dbg !1381

.thread:                                          ; preds = %130, %135
  %146 = phi i32 [ %145, %135 ], [ 0, %130 ]
  %147 = load i32* @done_on_match, align 4, !dbg !1383, !tbaa !778
  %148 = add nsw i32 %147, %146, !dbg !1383
  store i32 %148, i32* @done_on_match, align 4, !dbg !1383, !tbaa !778
  %149 = add nsw i32 %132, %146, !dbg !1384
  store i32 %149, i32* @out_quiet, align 4, !dbg !1384, !tbaa !778
  br label %150, !dbg !1385

; <label>:150                                     ; preds = %246, %.thread
  %residue.0.i = phi i64 [ 0, %.thread ], [ %197, %246 ]
  %save.0.i = phi i64 [ 0, %.thread ], [ %214, %246 ]
  %nlines.0.i = phi i32 [ 0, %.thread ], [ %nlines.2.i, %246 ]
  %151 = load i8** @bufbeg, align 8, !dbg !1387, !tbaa !717
  store i8* %151, i8** @lastnl, align 8, !dbg !1387, !tbaa !717
  %152 = load i8** @lastout, align 8, !dbg !1389, !tbaa !717
  %153 = icmp eq i8* %152, null, !dbg !1389
  br i1 %153, label %155, label %154, !dbg !1389

; <label>:154                                     ; preds = %150
  store i8* %151, i8** @lastout, align 8, !dbg !1391, !tbaa !717
  br label %155, !dbg !1391

; <label>:155                                     ; preds = %154, %150
  %156 = getelementptr inbounds i8* %151, i64 %save.0.i, !dbg !1392
  tail call void @llvm.dbg.value(metadata !{i8* %156}, i64 0, metadata !1393) #8, !dbg !1392
  %157 = load i8** @buflim, align 8, !dbg !1394, !tbaa !717
  %158 = icmp eq i8* %156, %157, !dbg !1394
  br i1 %158, label %256, label %159, !dbg !1394

; <label>:159                                     ; preds = %155
  %.sum.i = add i64 %save.0.i, -1, !dbg !1396
  %160 = getelementptr inbounds i8* %151, i64 %.sum.i, !dbg !1396
  %161 = load i8* %160, align 1, !dbg !1396, !tbaa !773
  tail call void @llvm.dbg.value(metadata !{i8 %161}, i64 0, metadata !1397) #8, !dbg !1396
  store i8 %55, i8* %160, align 1, !dbg !1398, !tbaa !773
  %162 = load i8** @buflim, align 8, !dbg !1399, !tbaa !717
  tail call void @llvm.dbg.value(metadata !{i8* %162}, i64 0, metadata !1401) #8, !dbg !1399
  br label %163, !dbg !1399

; <label>:163                                     ; preds = %163, %159
  %lim.0.i = phi i8* [ %162, %159 ], [ %164, %163 ]
  %164 = getelementptr inbounds i8* %lim.0.i, i64 -1, !dbg !1399
  %165 = load i8* %164, align 1, !dbg !1399, !tbaa !773
  %166 = icmp eq i8 %165, %55, !dbg !1399
  br i1 %166, label %167, label %163, !dbg !1399

; <label>:167                                     ; preds = %163
  store i8 %161, i8* %160, align 1, !dbg !1402, !tbaa !773
  %168 = icmp eq i8* %lim.0.i, %156, !dbg !1403
  %.sum19.i = sub i64 %save.0.i, %residue.0.i, !dbg !1405
  %169 = getelementptr inbounds i8* %151, i64 %.sum19.i, !dbg !1405
  %170 = load i8** @buflim, align 8, !dbg !1406, !tbaa !717
  %171 = ptrtoint i8* %170 to i64, !dbg !1406
  br i1 %168, label %.thread63, label %174, !dbg !1403

.thread63:                                        ; preds = %167
  tail call void @llvm.dbg.value(metadata !{i8* %169}, i64 0, metadata !1401) #8, !dbg !1405
  tail call void @llvm.dbg.value(metadata !{i8* %169}, i64 0, metadata !1393) #8, !dbg !1407
  %172 = ptrtoint i8* %169 to i64, !dbg !1406
  %173 = sub i64 %171, %172, !dbg !1406
  tail call void @llvm.dbg.value(metadata !{i64 %197}, i64 0, metadata !1362) #8, !dbg !1406
  br label %196, !dbg !1408

; <label>:174                                     ; preds = %167
  tail call void @llvm.dbg.value(metadata !{i8* %169}, i64 0, metadata !1393) #8, !dbg !1407
  %175 = ptrtoint i8* %lim.0.i to i64, !dbg !1406
  %176 = sub i64 %171, %175, !dbg !1406
  tail call void @llvm.dbg.value(metadata !{i64 %197}, i64 0, metadata !1362) #8, !dbg !1406
  %177 = icmp ult i8* %169, %lim.0.i, !dbg !1408
  br i1 %177, label %178, label %196, !dbg !1408

; <label>:178                                     ; preds = %174
  %179 = load i64* @outleft, align 8, !dbg !1410, !tbaa !775
  %180 = icmp eq i64 %179, 0, !dbg !1410
  br i1 %180, label %184, label %181, !dbg !1410

; <label>:181                                     ; preds = %178
  %182 = tail call fastcc i32 @grepbuf(i8* %169, i8* %lim.0.i) #8, !dbg !1413
  %183 = add nsw i32 %182, %nlines.0.i, !dbg !1413
  tail call void @llvm.dbg.value(metadata !{i32 %183}, i64 0, metadata !1360) #8, !dbg !1413
  br label %184, !dbg !1413

; <label>:184                                     ; preds = %181, %178
  %nlines.1.i = phi i32 [ %183, %181 ], [ %nlines.0.i, %178 ]
  %185 = load i32* @pending, align 4, !dbg !1414, !tbaa !778
  %186 = icmp eq i32 %185, 0, !dbg !1414
  br i1 %186, label %188, label %187, !dbg !1414

; <label>:187                                     ; preds = %184
  tail call fastcc void @prpending(i8* %lim.0.i) #8, !dbg !1416
  %.pre = load i32* @pending, align 4, !dbg !1417, !tbaa !778
  %phitmp = icmp ne i32 %.pre, 0, !dbg !1416
  br label %188, !dbg !1416

; <label>:188                                     ; preds = %187, %184
  %189 = phi i1 [ %phitmp, %187 ], [ false, %184 ]
  %190 = load i64* @outleft, align 8, !dbg !1417, !tbaa !775
  %191 = icmp ne i64 %190, 0, !dbg !1417
  %or.cond9.i = or i1 %191, %189, !dbg !1417
  br i1 %or.cond9.i, label %192, label %.loopexit21, !dbg !1417

; <label>:192                                     ; preds = %188
  %193 = load i32* @done_on_match, align 4, !dbg !1417, !tbaa !778
  %notlhs.i = icmp eq i32 %nlines.1.i, 0, !dbg !1417
  %notrhs.i = icmp eq i32 %193, 0, !dbg !1417
  %or.cond11.not.i = or i1 %notrhs.i, %notlhs.i, !dbg !1417
  %194 = load i32* @out_invert, align 4, !dbg !1417, !tbaa !778
  %195 = icmp ne i32 %194, 0, !dbg !1417
  %or.cond13.i = or i1 %or.cond11.not.i, %195, !dbg !1417
  br i1 %or.cond13.i, label %196, label %.loopexit21, !dbg !1417

; <label>:196                                     ; preds = %.thread63, %192, %174
  %197 = phi i64 [ %176, %192 ], [ %176, %174 ], [ %173, %.thread63 ]
  %lim.1.i64 = phi i8* [ %lim.0.i, %192 ], [ %lim.0.i, %174 ], [ %169, %.thread63 ]
  %nlines.2.i = phi i32 [ %nlines.1.i, %192 ], [ %nlines.0.i, %174 ], [ %nlines.0.i, %.thread63 ]
  tail call void @llvm.dbg.value(metadata !45, i64 0, metadata !1419) #8, !dbg !1420
  tail call void @llvm.dbg.value(metadata !{i8* %lim.1.i64}, i64 0, metadata !1393) #8, !dbg !1421
  %198 = load i32* @out_before, align 4, !dbg !1422, !tbaa !778
  %199 = load i8** @bufbeg, align 8, !dbg !1422, !tbaa !717
  %notlhs39 = icmp slt i32 %198, 1, !dbg !1422
  %notrhs40 = icmp ule i8* %lim.1.i64, %199, !dbg !1422
  %or.cond22.not.i41 = or i1 %notrhs40, %notlhs39, !dbg !1422
  %200 = load i8** @lastout, align 8, !dbg !1422, !tbaa !717
  %201 = icmp eq i8* %lim.1.i64, %200, !dbg !1422
  %or.cond24.i42 = or i1 %or.cond22.not.i41, %201, !dbg !1422
  br i1 %or.cond24.i42, label %.critedge.i, label %.lr.ph, !dbg !1422

.loopexit20:                                      ; preds = %204
  %202 = add nsw i32 %i.0.i43, 1, !dbg !1423
  %notlhs = icmp sge i32 %202, %198, !dbg !1422
  %notrhs = icmp ule i8* %205, %199, !dbg !1422
  %or.cond22.not.i = or i1 %notrhs, %notlhs, !dbg !1422
  %203 = icmp eq i8* %205, %200, !dbg !1422
  %or.cond24.i = or i1 %or.cond22.not.i, %203, !dbg !1422
  br i1 %or.cond24.i, label %.critedge.i, label %.lr.ph, !dbg !1422

.lr.ph:                                           ; preds = %196, %.loopexit20
  %beg.0.i44 = phi i8* [ %205, %.loopexit20 ], [ %lim.1.i64, %196 ]
  %i.0.i43 = phi i32 [ %202, %.loopexit20 ], [ 0, %196 ]
  tail call void @llvm.dbg.value(metadata !{i32 %202}, i64 0, metadata !1419) #8, !dbg !1423
  br label %204, !dbg !1425

; <label>:204                                     ; preds = %204, %.lr.ph
  %beg.1.i = phi i8* [ %beg.0.i44, %.lr.ph ], [ %205, %204 ]
  %205 = getelementptr inbounds i8* %beg.1.i, i64 -1, !dbg !1426
  tail call void @llvm.dbg.value(metadata !{i8* %205}, i64 0, metadata !1393) #8, !dbg !1426
  %206 = getelementptr inbounds i8* %beg.1.i, i64 -2, !dbg !1426
  %207 = load i8* %206, align 1, !dbg !1426, !tbaa !773
  %208 = icmp eq i8 %207, %55, !dbg !1426
  br i1 %208, label %.loopexit20, label %204, !dbg !1426

.critedge.i:                                      ; preds = %.loopexit20, %196
  %.lcssa25 = phi i1 [ %201, %196 ], [ %203, %.loopexit20 ]
  %beg.0.i.lcssa = phi i8* [ %lim.1.i64, %196 ], [ %205, %.loopexit20 ]
  br i1 %.lcssa25, label %210, label %209, !dbg !1427

; <label>:209                                     ; preds = %.critedge.i
  store i8* null, i8** @lastout, align 8, !dbg !1429, !tbaa !717
  br label %210, !dbg !1429

; <label>:210                                     ; preds = %209, %.critedge.i
  %211 = getelementptr inbounds i8* %lim.1.i64, i64 %197, !dbg !1430
  %212 = ptrtoint i8* %211 to i64, !dbg !1430
  %213 = ptrtoint i8* %beg.0.i.lcssa to i64, !dbg !1430
  %214 = sub i64 %212, %213, !dbg !1430
  tail call void @llvm.dbg.value(metadata !{i64 %214}, i64 0, metadata !1364) #8, !dbg !1430
  %.b.i13 = load i1* @out_byte, align 1
  br i1 %.b.i13, label %215, label %226, !dbg !1431

; <label>:215                                     ; preds = %210
  %216 = load i64* @totalcc, align 8, !dbg !1433, !tbaa !775
  %217 = load i8** @buflim, align 8, !dbg !1433, !tbaa !717
  %218 = ptrtoint i8* %217 to i64, !dbg !1433
  %219 = ptrtoint i8* %199 to i64, !dbg !1433
  %220 = sub i64 %218, %214, !dbg !1433
  %221 = sub i64 %220, %219, !dbg !1433
  tail call void @llvm.dbg.value(metadata !{i64 %216}, i64 0, metadata !1434) #8, !dbg !1435
  tail call void @llvm.dbg.value(metadata !{i64 %221}, i64 0, metadata !1436) #8, !dbg !1435
  %uadd.i.i = tail call { i64, i1 } @llvm.uadd.with.overflow.i64(i64 %216, i64 %221) #8, !dbg !1437
  %222 = extractvalue { i64, i1 } %uadd.i.i, 0, !dbg !1437
  tail call void @llvm.dbg.value(metadata !{i64 %222}, i64 0, metadata !1438) #8, !dbg !1437
  %223 = extractvalue { i64, i1 } %uadd.i.i, 1, !dbg !1439
  br i1 %223, label %224, label %add_count.exit.i, !dbg !1439

; <label>:224                                     ; preds = %215
  %225 = tail call i8* @dcgettext(i8* null, i8* getelementptr inbounds ([28 x i8]* @.str62, i64 0, i64 0), i32 5) #8, !dbg !1441
  tail call void (i32, i32, i8*, ...)* @error(i32 2, i32 0, i8* %225) #8, !dbg !1441
  br label %add_count.exit.i, !dbg !1441

add_count.exit.i:                                 ; preds = %224, %215
  store i64 %222, i64* @totalcc, align 8, !dbg !1433, !tbaa !775
  br label %226, !dbg !1433

; <label>:226                                     ; preds = %add_count.exit.i, %210
  %.b17.i = load i1* @out_line, align 1
  br i1 %.b17.i, label %227, label %246, !dbg !1442

; <label>:227                                     ; preds = %226
  tail call void @llvm.dbg.value(metadata !{i8* %beg.0.i.lcssa}, i64 0, metadata !1444) #8, !dbg !1446
  tail call void @llvm.dbg.value(metadata !769, i64 0, metadata !1447) #8, !dbg !1448
  %228 = load i8** @lastnl, align 8, !dbg !1449, !tbaa !717
  tail call void @llvm.dbg.value(metadata !{i8* %228}, i64 0, metadata !1451) #8, !dbg !1449
  %229 = icmp ult i8* %228, %beg.0.i.lcssa, !dbg !1449
  br i1 %229, label %.lr.ph.i.i, label %split3.i.i, !dbg !1449

.lr.ph.i.i:                                       ; preds = %227
  %230 = load i8* @eolbyte, align 1, !dbg !1452, !tbaa !773
  %231 = zext i8 %230 to i32, !dbg !1452
  br label %232, !dbg !1449

; <label>:232                                     ; preds = %237, %.lr.ph.i.i
  %beg.02.i.i = phi i8* [ %228, %.lr.ph.i.i ], [ %239, %237 ]
  %newlines.01.i.i = phi i64 [ 0, %.lr.ph.i.i ], [ %238, %237 ]
  %233 = ptrtoint i8* %beg.02.i.i to i64, !dbg !1452
  %234 = sub i64 %213, %233, !dbg !1452
  %235 = tail call i8* @memchr(i8* %beg.02.i.i, i32 %231, i64 %234) #12, !dbg !1452
  tail call void @llvm.dbg.value(metadata !{i8* %235}, i64 0, metadata !1451) #8, !dbg !1452
  %236 = icmp eq i8* %235, null, !dbg !1454
  br i1 %236, label %split3.i.i, label %237, !dbg !1454

; <label>:237                                     ; preds = %232
  %238 = add i64 %newlines.01.i.i, 1, !dbg !1456
  tail call void @llvm.dbg.value(metadata !{i64 %238}, i64 0, metadata !1447) #8, !dbg !1456
  %239 = getelementptr inbounds i8* %235, i64 1, !dbg !1449
  tail call void @llvm.dbg.value(metadata !{i8* %239}, i64 0, metadata !1451) #8, !dbg !1449
  %240 = icmp ult i8* %239, %beg.0.i.lcssa, !dbg !1449
  br i1 %240, label %232, label %split3.i.i, !dbg !1449

split3.i.i:                                       ; preds = %237, %232, %227
  %newlines.0.lcssa.i.i = phi i64 [ 0, %227 ], [ %238, %237 ], [ %newlines.01.i.i, %232 ]
  %241 = load i64* @totalnl, align 8, !dbg !1457, !tbaa !775
  tail call void @llvm.dbg.value(metadata !{i64 %241}, i64 0, metadata !1458) #8, !dbg !1459
  tail call void @llvm.dbg.value(metadata !{i64 %newlines.0.lcssa.i.i}, i64 0, metadata !1460) #8, !dbg !1459
  %uadd.i.i.i = tail call { i64, i1 } @llvm.uadd.with.overflow.i64(i64 %241, i64 %newlines.0.lcssa.i.i) #8, !dbg !1461
  %242 = extractvalue { i64, i1 } %uadd.i.i.i, 0, !dbg !1461
  tail call void @llvm.dbg.value(metadata !{i64 %242}, i64 0, metadata !1462) #8, !dbg !1461
  %243 = extractvalue { i64, i1 } %uadd.i.i.i, 1, !dbg !1463
  br i1 %243, label %244, label %nlscan.exit.i, !dbg !1463

; <label>:244                                     ; preds = %split3.i.i
  %245 = tail call i8* @dcgettext(i8* null, i8* getelementptr inbounds ([28 x i8]* @.str62, i64 0, i64 0), i32 5) #8, !dbg !1464
  tail call void (i32, i32, i8*, ...)* @error(i32 2, i32 0, i8* %245) #8, !dbg !1464
  br label %nlscan.exit.i, !dbg !1464

nlscan.exit.i:                                    ; preds = %244, %split3.i.i
  store i64 %242, i64* @totalnl, align 8, !dbg !1457, !tbaa !775
  store i8* %beg.0.i.lcssa, i8** @lastnl, align 8, !dbg !1465, !tbaa !717
  br label %246, !dbg !1445

; <label>:246                                     ; preds = %nlscan.exit.i, %226
  %247 = tail call fastcc i32 @fillbuf(i64 %214, %struct.stats* %stats) #8, !dbg !1466
  %248 = icmp eq i32 %247, 0, !dbg !1466
  br i1 %248, label %249, label %150, !dbg !1466

; <label>:249                                     ; preds = %246
  %250 = tail call i32* @__errno_location() #1, !dbg !1468
  %251 = load i32* %250, align 4, !dbg !1468, !tbaa !778
  %252 = icmp eq i32 %251, 21, !dbg !1468
  br i1 %252, label %.loopexit21, label %253, !dbg !1468

; <label>:253                                     ; preds = %249
  tail call void @llvm.dbg.value(metadata !{i8* %255}, i64 0, metadata !1471) #8, !dbg !1473
  tail call void @llvm.dbg.value(metadata !{i32 %251}, i64 0, metadata !1474) #8, !dbg !1473
  %.b.i25.i = load i1* @suppress_errors, align 1
  br i1 %.b.i25.i, label %suppressible_error.exit26.i, label %254, !dbg !1475

; <label>:254                                     ; preds = %253
  %255 = load i8** @filename, align 8, !dbg !1472, !tbaa !717
  tail call void (i32, i32, i8*, ...)* @error(i32 0, i32 %251, i8* getelementptr inbounds ([3 x i8]* @.str3, i64 0, i64 0), i8* %255) #8, !dbg !1476
  br label %suppressible_error.exit26.i, !dbg !1476

suppressible_error.exit26.i:                      ; preds = %254, %253
  store i1 true, i1* @errseen, align 1
  br label %.loopexit21, !dbg !1472

; <label>:256                                     ; preds = %155
  %257 = icmp eq i64 %residue.0.i, 0, !dbg !1477
  br i1 %257, label %.loopexit21, label %258, !dbg !1477

; <label>:258                                     ; preds = %256
  %.sum = add i64 %save.0.i, 1, !dbg !1479
  %259 = getelementptr inbounds i8* %151, i64 %.sum, !dbg !1479
  store i8* %259, i8** @buflim, align 8, !dbg !1479, !tbaa !717
  store i8 %55, i8* %156, align 1, !dbg !1479, !tbaa !773
  %260 = load i64* @outleft, align 8, !dbg !1481, !tbaa !775
  %261 = icmp eq i64 %260, 0, !dbg !1481
  br i1 %261, label %268, label %262, !dbg !1481

; <label>:262                                     ; preds = %258
  %263 = load i8** @bufbeg, align 8, !dbg !1483, !tbaa !717
  %.sum20.i = sub i64 %save.0.i, %residue.0.i, !dbg !1483
  %264 = getelementptr inbounds i8* %263, i64 %.sum20.i, !dbg !1483
  %265 = load i8** @buflim, align 8, !dbg !1483, !tbaa !717
  %266 = tail call fastcc i32 @grepbuf(i8* %264, i8* %265) #8, !dbg !1483
  %267 = add nsw i32 %266, %nlines.0.i, !dbg !1483
  tail call void @llvm.dbg.value(metadata !{i32 %267}, i64 0, metadata !1360) #8, !dbg !1483
  br label %268, !dbg !1483

; <label>:268                                     ; preds = %262, %258
  %nlines.3.i = phi i32 [ %267, %262 ], [ %nlines.0.i, %258 ]
  %269 = load i32* @pending, align 4, !dbg !1484, !tbaa !778
  %270 = icmp eq i32 %269, 0, !dbg !1484
  br i1 %270, label %.loopexit21, label %271, !dbg !1484

; <label>:271                                     ; preds = %268
  %272 = load i8** @buflim, align 8, !dbg !1486, !tbaa !717
  tail call fastcc void @prpending(i8* %272) #8, !dbg !1486
  br label %.loopexit21, !dbg !1486

.loopexit21:                                      ; preds = %192, %188, %271, %268, %256, %suppressible_error.exit26.i, %249
  %nlines.4.i = phi i32 [ %nlines.3.i, %271 ], [ %nlines.3.i, %268 ], [ %nlines.0.i, %256 ], [ %nlines.2.i, %249 ], [ %nlines.2.i, %suppressible_error.exit26.i ], [ %nlines.1.i, %188 ], [ %nlines.1.i, %192 ]
  %273 = load i32* @done_on_match, align 4, !dbg !1487, !tbaa !778
  %274 = sub nsw i32 %273, %146, !dbg !1487
  store i32 %274, i32* @done_on_match, align 4, !dbg !1487, !tbaa !778
  %275 = load i32* @out_quiet, align 4, !dbg !1488, !tbaa !778
  %276 = sub nsw i32 %275, %146, !dbg !1488
  store i32 %276, i32* @out_quiet, align 4, !dbg !1488, !tbaa !778
  %277 = xor i32 %276, -1, !dbg !1489
  %278 = and i32 %146, %277, !dbg !1489
  %279 = icmp ne i32 %278, 0, !dbg !1489
  %280 = icmp ne i32 %nlines.4.i, 0, !dbg !1489
  %or.cond16.i = and i1 %279, %280, !dbg !1489
  br i1 %or.cond16.i, label %281, label %grep.exit, !dbg !1489

; <label>:281                                     ; preds = %.loopexit21
  %282 = tail call i8* @dcgettext(i8* null, i8* getelementptr inbounds ([24 x i8]* @.str61, i64 0, i64 0), i32 5) #8, !dbg !1491
  %283 = load i8** @filename, align 8, !dbg !1491, !tbaa !717
  %284 = tail call i32 (i8*, ...)* @printf(i8* %282, i8* %283) #8, !dbg !1491
  br label %grep.exit, !dbg !1491

grep.exit:                                        ; preds = %116, %.loopexit21, %281
  %.0.i = phi i32 [ %118, %116 ], [ %nlines.4.i, %281 ], [ %nlines.4.i, %.loopexit21 ]
  tail call void @llvm.dbg.value(metadata !{i32 %.0.i16}, i64 0, metadata !255), !dbg !1310
  %285 = icmp slt i32 %.0.i, 0, !dbg !1492
  br i1 %285, label %286, label %grep.exit.thread, !dbg !1492

; <label>:286                                     ; preds = %grep.exit
  %287 = add nsw i32 %.0.i, 2, !dbg !1493
  tail call void @llvm.dbg.value(metadata !{i32 %287}, i64 0, metadata !256), !dbg !1493
  br label %.loopexit, !dbg !1493

grep.exit.thread:                                 ; preds = %135, %123, %suppressible_error.exit.i, %reset.exit.i, %grep.exit
  %.0.i16 = phi i32 [ %.0.i, %grep.exit ], [ 0, %reset.exit.i ], [ 0, %suppressible_error.exit.i ], [ 0, %123 ], [ 0, %135 ]
  %.b6 = load i1* @count_matches, align 1
  br i1 %.b6, label %288, label %356, !dbg !1494

; <label>:288                                     ; preds = %grep.exit.thread
  %289 = load i32* @out_file, align 4, !dbg !1496, !tbaa !778
  %290 = icmp eq i32 %289, 0, !dbg !1496
  br i1 %290, label %print_sep.exit, label %291, !dbg !1496

; <label>:291                                     ; preds = %288
  %292 = load i32* @color_option, align 4, !dbg !1499, !tbaa !778
  %293 = icmp eq i32 %292, 0, !dbg !1499
  br i1 %293, label %301, label %294, !dbg !1499

; <label>:294                                     ; preds = %291
  %295 = load i8** @filename_color, align 8, !dbg !1499, !tbaa !717
  %296 = load i8* %295, align 1, !dbg !1499, !tbaa !773
  %297 = icmp eq i8 %296, 0, !dbg !1499
  br i1 %297, label %301, label %298, !dbg !1499

; <label>:298                                     ; preds = %294
  %299 = load i8** @sgr_start, align 8, !dbg !1499, !tbaa !717
  %300 = tail call i32 (i8*, ...)* @printf(i8* %299, i8* %295) #8, !dbg !1499
  br label %301, !dbg !1499

; <label>:301                                     ; preds = %298, %294, %291
  %302 = load i8** @filename, align 8, !dbg !1504, !tbaa !717
  %303 = load %struct._IO_FILE** @stdout, align 8, !dbg !1504, !tbaa !717
  %304 = tail call i32 @fputs_unlocked(i8* %302, %struct._IO_FILE* %303) #8, !dbg !1504
  %305 = load i32* @color_option, align 4, !dbg !1505, !tbaa !778
  %306 = icmp eq i32 %305, 0, !dbg !1505
  br i1 %306, label %print_filename.exit12, label %307, !dbg !1505

; <label>:307                                     ; preds = %301
  %308 = load i8** @filename_color, align 8, !dbg !1505, !tbaa !717
  %309 = load i8* %308, align 1, !dbg !1505, !tbaa !773
  %310 = icmp eq i8 %309, 0, !dbg !1505
  br i1 %310, label %print_filename.exit12, label %311, !dbg !1505

; <label>:311                                     ; preds = %307
  %312 = load i8** @sgr_end, align 8, !dbg !1505, !tbaa !717
  %313 = tail call i32 (i8*, ...)* @printf(i8* %312, i8* %308) #8, !dbg !1505
  br label %print_filename.exit12, !dbg !1505

print_filename.exit12:                            ; preds = %301, %307, %311
  %.b4 = load i1* @filename_mask, align 1
  br i1 %.b4, label %314, label %344, !dbg !1508

; <label>:314                                     ; preds = %print_filename.exit12
  tail call void @llvm.dbg.value(metadata !1510, i64 0, metadata !1511) #8, !dbg !1513
  %315 = load i32* @color_option, align 4, !dbg !1514, !tbaa !778
  %316 = icmp eq i32 %315, 0, !dbg !1514
  br i1 %316, label %324, label %317, !dbg !1514

; <label>:317                                     ; preds = %314
  %318 = load i8** @sep_color, align 8, !dbg !1514, !tbaa !717
  %319 = load i8* %318, align 1, !dbg !1514, !tbaa !773
  %320 = icmp eq i8 %319, 0, !dbg !1514
  br i1 %320, label %324, label %321, !dbg !1514

; <label>:321                                     ; preds = %317
  %322 = load i8** @sgr_start, align 8, !dbg !1514, !tbaa !717
  %323 = tail call i32 (i8*, ...)* @printf(i8* %322, i8* %318) #8, !dbg !1514
  br label %324, !dbg !1514

; <label>:324                                     ; preds = %321, %317, %314
  %325 = load %struct._IO_FILE** @stdout, align 8, !dbg !1518, !tbaa !717
  tail call void @llvm.dbg.value(metadata !1519, i64 0, metadata !1520) #8, !dbg !1521
  tail call void @llvm.dbg.value(metadata !{%struct._IO_FILE* %325}, i64 0, metadata !1522) #8, !dbg !1521
  %326 = getelementptr inbounds %struct._IO_FILE* %325, i64 0, i32 5, !dbg !1523
  %327 = load i8** %326, align 8, !dbg !1523, !tbaa !1525
  %328 = getelementptr inbounds %struct._IO_FILE* %325, i64 0, i32 6, !dbg !1523
  %329 = load i8** %328, align 8, !dbg !1523, !tbaa !1526
  %330 = icmp ult i8* %327, %329, !dbg !1523
  br i1 %330, label %333, label %331, !dbg !1523, !prof !1527

; <label>:331                                     ; preds = %324
  %332 = tail call i32 @__overflow(%struct._IO_FILE* %325, i32 58) #8, !dbg !1523
  br label %fputc_unlocked.exit14, !dbg !1523

; <label>:333                                     ; preds = %324
  %334 = getelementptr inbounds i8* %327, i64 1, !dbg !1523
  store i8* %334, i8** %326, align 8, !dbg !1523, !tbaa !1525
  store i8 58, i8* %327, align 1, !dbg !1523, !tbaa !773
  br label %fputc_unlocked.exit14, !dbg !1523

fputc_unlocked.exit14:                            ; preds = %331, %333
  %335 = load i32* @color_option, align 4, !dbg !1528, !tbaa !778
  %336 = icmp eq i32 %335, 0, !dbg !1528
  br i1 %336, label %print_sep.exit, label %337, !dbg !1528

; <label>:337                                     ; preds = %fputc_unlocked.exit14
  %338 = load i8** @sep_color, align 8, !dbg !1528, !tbaa !717
  %339 = load i8* %338, align 1, !dbg !1528, !tbaa !773
  %340 = icmp eq i8 %339, 0, !dbg !1528
  br i1 %340, label %print_sep.exit, label %341, !dbg !1528

; <label>:341                                     ; preds = %337
  %342 = load i8** @sgr_end, align 8, !dbg !1528, !tbaa !717
  %343 = tail call i32 (i8*, ...)* @printf(i8* %342, i8* %338) #8, !dbg !1528
  br label %print_sep.exit, !dbg !1528

; <label>:344                                     ; preds = %print_filename.exit12
  %345 = load %struct._IO_FILE** @stdout, align 8, !dbg !1531, !tbaa !717
  tail call void @llvm.dbg.value(metadata !45, i64 0, metadata !1532) #8, !dbg !1533
  tail call void @llvm.dbg.value(metadata !{%struct._IO_FILE* %345}, i64 0, metadata !1534) #8, !dbg !1533
  %346 = getelementptr inbounds %struct._IO_FILE* %345, i64 0, i32 5, !dbg !1535
  %347 = load i8** %346, align 8, !dbg !1535, !tbaa !1525
  %348 = getelementptr inbounds %struct._IO_FILE* %345, i64 0, i32 6, !dbg !1535
  %349 = load i8** %348, align 8, !dbg !1535, !tbaa !1526
  %350 = icmp ult i8* %347, %349, !dbg !1535
  br i1 %350, label %353, label %351, !dbg !1535, !prof !1527

; <label>:351                                     ; preds = %344
  %352 = tail call i32 @__overflow(%struct._IO_FILE* %345, i32 0) #8, !dbg !1535
  br label %print_sep.exit, !dbg !1535

; <label>:353                                     ; preds = %344
  %354 = getelementptr inbounds i8* %347, i64 1, !dbg !1535
  store i8* %354, i8** %346, align 8, !dbg !1535, !tbaa !1525
  store i8 0, i8* %347, align 1, !dbg !1535, !tbaa !773
  br label %print_sep.exit, !dbg !1535

print_sep.exit:                                   ; preds = %353, %351, %341, %337, %fputc_unlocked.exit14, %288
  %355 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str56, i64 0, i64 0), i32 %.0.i16) #8, !dbg !1536
  br label %356, !dbg !1537

; <label>:356                                     ; preds = %print_sep.exit, %grep.exit.thread
  %357 = icmp eq i32 %.0.i16, 0, !dbg !1538
  %358 = zext i1 %357 to i32, !dbg !1538
  tail call void @llvm.dbg.value(metadata !{i32 %358}, i64 0, metadata !256), !dbg !1538
  %359 = load i32* @list_files, align 4, !dbg !1539, !tbaa !778
  %360 = shl nuw nsw i32 %358, 1, !dbg !1539
  %361 = sub nsw i32 1, %360, !dbg !1539
  %362 = icmp eq i32 %359, %361, !dbg !1539
  br i1 %362, label %363, label %fputc_unlocked.exit, !dbg !1539

; <label>:363                                     ; preds = %356
  %364 = load i32* @color_option, align 4, !dbg !1541, !tbaa !778
  %365 = icmp eq i32 %364, 0, !dbg !1541
  br i1 %365, label %373, label %366, !dbg !1541

; <label>:366                                     ; preds = %363
  %367 = load i8** @filename_color, align 8, !dbg !1541, !tbaa !717
  %368 = load i8* %367, align 1, !dbg !1541, !tbaa !773
  %369 = icmp eq i8 %368, 0, !dbg !1541
  br i1 %369, label %373, label %370, !dbg !1541

; <label>:370                                     ; preds = %366
  %371 = load i8** @sgr_start, align 8, !dbg !1541, !tbaa !717
  %372 = tail call i32 (i8*, ...)* @printf(i8* %371, i8* %367) #8, !dbg !1541
  br label %373, !dbg !1541

; <label>:373                                     ; preds = %370, %366, %363
  %374 = load i8** @filename, align 8, !dbg !1544, !tbaa !717
  %375 = load %struct._IO_FILE** @stdout, align 8, !dbg !1544, !tbaa !717
  %376 = tail call i32 @fputs_unlocked(i8* %374, %struct._IO_FILE* %375) #8, !dbg !1544
  %377 = load i32* @color_option, align 4, !dbg !1545, !tbaa !778
  %378 = icmp eq i32 %377, 0, !dbg !1545
  br i1 %378, label %print_filename.exit, label %379, !dbg !1545

; <label>:379                                     ; preds = %373
  %380 = load i8** @filename_color, align 8, !dbg !1545, !tbaa !717
  %381 = load i8* %380, align 1, !dbg !1545, !tbaa !773
  %382 = icmp eq i8 %381, 0, !dbg !1545
  br i1 %382, label %print_filename.exit, label %383, !dbg !1545

; <label>:383                                     ; preds = %379
  %384 = load i8** @sgr_end, align 8, !dbg !1545, !tbaa !717
  %385 = tail call i32 (i8*, ...)* @printf(i8* %384, i8* %380) #8, !dbg !1545
  br label %print_filename.exit, !dbg !1545

print_filename.exit:                              ; preds = %373, %379, %383
  %.b = load i1* @filename_mask, align 1
  %386 = select i1 %.b, i32 10, i32 0, !dbg !1546
  %387 = load %struct._IO_FILE** @stdout, align 8, !dbg !1546, !tbaa !717
  tail call void @llvm.dbg.value(metadata !{i32 %386}, i64 0, metadata !1547) #8, !dbg !1548
  tail call void @llvm.dbg.value(metadata !{%struct._IO_FILE* %387}, i64 0, metadata !1549) #8, !dbg !1548
  %388 = getelementptr inbounds %struct._IO_FILE* %387, i64 0, i32 5, !dbg !1550
  %389 = load i8** %388, align 8, !dbg !1550, !tbaa !1525
  %390 = getelementptr inbounds %struct._IO_FILE* %387, i64 0, i32 6, !dbg !1550
  %391 = load i8** %390, align 8, !dbg !1550, !tbaa !1526
  %392 = icmp ult i8* %389, %391, !dbg !1550
  br i1 %392, label %395, label %393, !dbg !1550, !prof !1527

; <label>:393                                     ; preds = %print_filename.exit
  %394 = tail call i32 @__overflow(%struct._IO_FILE* %387, i32 %386) #8, !dbg !1550
  br label %fputc_unlocked.exit, !dbg !1550

; <label>:395                                     ; preds = %print_filename.exit
  %396 = trunc i32 %386 to i8, !dbg !1550
  %397 = getelementptr inbounds i8* %389, i64 1, !dbg !1550
  store i8* %397, i8** %388, align 8, !dbg !1550, !tbaa !1525
  store i8 %396, i8* %389, align 1, !dbg !1550, !tbaa !773
  br label %fputc_unlocked.exit, !dbg !1550

fputc_unlocked.exit:                              ; preds = %395, %393, %356
  br i1 %1, label %.preheader, label %398, !dbg !1551

; <label>:398                                     ; preds = %fputc_unlocked.exit
  %399 = load i64* @outleft, align 8, !dbg !1552, !tbaa !775
  %400 = icmp ne i64 %399, 0, !dbg !1552
  %401 = load i64* @bufoffset, align 8, !dbg !1552, !tbaa !775
  %402 = load i64* @after_last_match, align 8, !dbg !1552, !tbaa !775
  %403 = select i1 %400, i64 %401, i64 %402, !dbg !1552
  tail call void @llvm.dbg.value(metadata !{i64 %403}, i64 0, metadata !262), !dbg !1552
  %404 = icmp eq i64 %403, %401, !dbg !1553
  br i1 %404, label %.loopexit, label %405, !dbg !1553

; <label>:405                                     ; preds = %398
  %406 = tail call i64 @lseek(i32 %desc.0, i64 %403, i32 0) #8, !dbg !1555
  %407 = icmp slt i64 %406, 0, !dbg !1555
  br i1 %407, label %408, label %.loopexit, !dbg !1555

; <label>:408                                     ; preds = %405
  %409 = load i32* %90, align 4, !dbg !1555, !tbaa !1269
  %410 = and i32 %409, 61440, !dbg !1555
  %411 = icmp eq i32 %410, 32768, !dbg !1555
  br i1 %411, label %412, label %.loopexit, !dbg !1555

; <label>:412                                     ; preds = %408
  %413 = tail call i32* @__errno_location() #1, !dbg !1556
  %414 = load i32* %413, align 4, !dbg !1556, !tbaa !778
  %415 = load i8** @filename, align 8, !dbg !1556, !tbaa !717
  tail call void (i32, i32, i8*, ...)* @error(i32 0, i32 %414, i8* getelementptr inbounds ([3 x i8]* @.str3, i64 0, i64 0), i8* %415) #8, !dbg !1556
  br label %.loopexit, !dbg !1556

.preheader:                                       ; preds = %fputc_unlocked.exit, %418
  %416 = tail call i32 @close(i32 %desc.0) #8, !dbg !1557
  %417 = icmp eq i32 %416, 0, !dbg !1557
  br i1 %417, label %.loopexit, label %418, !dbg !1557

; <label>:418                                     ; preds = %.preheader
  %419 = tail call i32* @__errno_location() #1, !dbg !1558
  %420 = load i32* %419, align 4, !dbg !1558, !tbaa !778
  %421 = icmp eq i32 %420, 4, !dbg !1558
  br i1 %421, label %.preheader, label %422, !dbg !1558

; <label>:422                                     ; preds = %418
  tail call void (i32, i32, i8*, ...)* @error(i32 0, i32 %420, i8* getelementptr inbounds ([3 x i8]* @.str3, i64 0, i64 0), i8* %file) #8, !dbg !1560
  br label %.loopexit, !dbg !1562

.loopexit:                                        ; preds = %.preheader, %286, %422, %405, %408, %412, %398, %49, %48, %24, %24, %24, %24, %18, %suppressible_error.exit11, %43, %41, %suppressible_error.exit
  %.0 = phi i32 [ 1, %suppressible_error.exit ], [ 1, %41 ], [ %44, %43 ], [ 1, %suppressible_error.exit11 ], [ 1, %18 ], [ 1, %24 ], [ 1, %24 ], [ 1, %24 ], [ 1, %24 ], [ 1, %48 ], [ 1, %49 ], [ %287, %286 ], [ %358, %422 ], [ %358, %412 ], [ %358, %408 ], [ %358, %405 ], [ %358, %398 ], [ %358, %.preheader ]
  ret i32 %.0, !dbg !1563
}

declare i32 @open(i8* nocapture readonly, i32, ...) #3

; Function Attrs: nounwind uwtable
define internal fastcc i32 @grepdir(i8* %dir, %struct.stats* %stats) #6 {
  %child = alloca %struct.stats, align 8
  call void @llvm.dbg.value(metadata !{i8* %dir}, i64 0, metadata !467), !dbg !1564
  call void @llvm.dbg.value(metadata !{%struct.stats* %stats}, i64 0, metadata !468), !dbg !1564
  call void @llvm.dbg.value(metadata !895, i64 0, metadata !471), !dbg !1565
  %1 = load %struct.exclude** @excluded_directory_patterns, align 8, !dbg !1566, !tbaa !717
  %2 = icmp eq %struct.exclude* %1, null, !dbg !1566
  br i1 %2, label %5, label %3, !dbg !1566

; <label>:3                                       ; preds = %0
  %4 = call zeroext i1 @excluded_file_name(%struct.exclude* %1, i8* %dir) #8, !dbg !1568
  br i1 %4, label %82, label %5, !dbg !1568

; <label>:5                                       ; preds = %0, %3
  %6 = getelementptr inbounds %struct.stats* %stats, i64 0, i32 1, i32 1, !dbg !1569
  %7 = load i64* %6, align 8, !dbg !1569, !tbaa !1571
  %8 = icmp eq i64 %7, 0, !dbg !1569
  br i1 %8, label %.loopexit, label %.preheader, !dbg !1569

.preheader:                                       ; preds = %5
  %9 = getelementptr inbounds %struct.stats* %stats, i64 0, i32 0, !dbg !1572
  %10 = load %struct.stats** %9, align 8, !dbg !1572, !tbaa !1574
  call void @llvm.dbg.value(metadata !{%struct.stats* %10}, i64 0, metadata !469), !dbg !1572
  %11 = icmp eq %struct.stats* %10, null, !dbg !1572
  br i1 %11, label %.loopexit, label %.lr.ph7, !dbg !1572

.lr.ph7:                                          ; preds = %.preheader
  %12 = getelementptr inbounds %struct.stats* %stats, i64 0, i32 1, i32 0, !dbg !1575
  br label %13, !dbg !1572

; <label>:13                                      ; preds = %.lr.ph7, %.backedge
  %14 = phi %struct.stats* [ %10, %.lr.ph7 ], [ %24, %.backedge ]
  %15 = getelementptr inbounds %struct.stats* %14, i64 0, i32 1, i32 1, !dbg !1575
  %16 = load i64* %15, align 8, !dbg !1575, !tbaa !1571
  %17 = icmp eq i64 %16, %7, !dbg !1575
  br i1 %17, label %18, label %.backedge, !dbg !1575

; <label>:18                                      ; preds = %13
  %19 = getelementptr inbounds %struct.stats* %14, i64 0, i32 1, i32 0, !dbg !1575
  %20 = load i64* %19, align 8, !dbg !1575, !tbaa !1577
  %21 = load i64* %12, align 8, !dbg !1575, !tbaa !1577
  %22 = icmp eq i64 %20, %21, !dbg !1575
  br i1 %22, label %26, label %.backedge, !dbg !1575

.backedge:                                        ; preds = %18, %13
  %23 = getelementptr inbounds %struct.stats* %14, i64 0, i32 0, !dbg !1572
  %24 = load %struct.stats** %23, align 8, !dbg !1572, !tbaa !1574
  call void @llvm.dbg.value(metadata !{%struct.stats* %14}, i64 0, metadata !469), !dbg !1572
  %25 = icmp eq %struct.stats* %24, null, !dbg !1572
  br i1 %25, label %.loopexit, label %13, !dbg !1572

; <label>:26                                      ; preds = %18
  %.b2 = load i1* @suppress_errors, align 1
  br i1 %.b2, label %82, label %27, !dbg !1578

; <label>:27                                      ; preds = %26
  %28 = call i8* @dcgettext(i8* null, i8* getelementptr inbounds ([16 x i8]* @.str68, i64 0, i64 0), i32 5) #8, !dbg !1581
  %29 = call i8* @dcgettext(i8* null, i8* getelementptr inbounds ([25 x i8]* @.str69, i64 0, i64 0), i32 5) #8, !dbg !1582
  call void (i32, i32, i8*, ...)* @error(i32 0, i32 0, i8* %28, i8* %dir, i8* %29) #8, !dbg !1581
  br label %82, !dbg !1581

.loopexit:                                        ; preds = %.backedge, %.preheader, %5
  %30 = getelementptr inbounds %struct.stats* %stats, i64 0, i32 1, i32 8, !dbg !1583
  %31 = load i64* %30, align 8, !dbg !1583, !tbaa !1584
  %32 = load %struct.exclude** @included_patterns, align 8, !dbg !1583, !tbaa !717
  %33 = load %struct.exclude** @excluded_patterns, align 8, !dbg !1583, !tbaa !717
  %34 = load %struct.exclude** @excluded_directory_patterns, align 8, !dbg !1583, !tbaa !717
  %35 = call i8* @savedir(i8* %dir, i64 %31, %struct.exclude* %32, %struct.exclude* %33, %struct.exclude* %34) #8, !dbg !1583
  call void @llvm.dbg.value(metadata !{i8* %35}, i64 0, metadata !470), !dbg !1583
  %36 = icmp eq i8* %35, null, !dbg !1585
  br i1 %36, label %37, label %44, !dbg !1585

; <label>:37                                      ; preds = %.loopexit
  %38 = call i32* @__errno_location() #1, !dbg !1586
  %39 = load i32* %38, align 4, !dbg !1586, !tbaa !778
  %40 = icmp eq i32 %39, 0, !dbg !1586
  br i1 %40, label %43, label %41, !dbg !1586

; <label>:41                                      ; preds = %37
  call void @llvm.dbg.value(metadata !{i8* %dir}, i64 0, metadata !1589) #8, !dbg !1591
  call void @llvm.dbg.value(metadata !{i32 %39}, i64 0, metadata !1592) #8, !dbg !1591
  %.b.i = load i1* @suppress_errors, align 1
  br i1 %.b.i, label %suppressible_error.exit, label %42, !dbg !1593

; <label>:42                                      ; preds = %41
  call void (i32, i32, i8*, ...)* @error(i32 0, i32 %39, i8* getelementptr inbounds ([3 x i8]* @.str3, i64 0, i64 0), i8* %dir) #8, !dbg !1594
  br label %suppressible_error.exit, !dbg !1594

suppressible_error.exit:                          ; preds = %41, %42
  store i1 true, i1* @errseen, align 1
  br label %82, !dbg !1595

; <label>:43                                      ; preds = %37
  call void @xalloc_die() #11, !dbg !1596
  unreachable, !dbg !1596

; <label>:44                                      ; preds = %.loopexit
  %45 = call i64 @strlen(i8* %dir) #12, !dbg !1597
  call void @llvm.dbg.value(metadata !{i64 %45}, i64 0, metadata !472), !dbg !1597
  %46 = icmp eq i64 %45, 0, !dbg !1598
  br i1 %46, label %51, label %47, !dbg !1598

; <label>:47                                      ; preds = %44
  %48 = add i64 %45, -1, !dbg !1598
  %49 = getelementptr inbounds i8* %dir, i64 %48, !dbg !1598
  %50 = load i8* %49, align 1, !dbg !1598, !tbaa !773
  %phitmp = icmp ne i8 %50, 47, !dbg !1598
  br label %51, !dbg !1598

; <label>:51                                      ; preds = %47, %44
  %52 = phi i1 [ false, %44 ], [ %phitmp, %47 ]
  call void @llvm.dbg.value(metadata !767, i64 0, metadata !476), !dbg !1599
  call void @llvm.dbg.value(metadata !{i8* %35}, i64 0, metadata !477), !dbg !1600
  %53 = bitcast %struct.stats* %child to i8*, !dbg !1601
  call void @llvm.lifetime.start(i64 152, i8* %53) #8, !dbg !1601
  call void @llvm.dbg.declare(metadata !{%struct.stats* %child}, metadata !478), !dbg !1601
  %54 = getelementptr inbounds %struct.stats* %child, i64 0, i32 0, !dbg !1602
  store %struct.stats* %stats, %struct.stats** %54, align 8, !dbg !1602, !tbaa !1574
  %.b1 = load i1* @no_filenames, align 1
  %55 = zext i1 %.b1 to i32, !dbg !1603
  %56 = xor i32 %55, 1, !dbg !1603
  %57 = load i32* @out_file, align 4, !dbg !1603, !tbaa !778
  %58 = add nsw i32 %56, %57, !dbg !1603
  store i32 %58, i32* @out_file, align 4, !dbg !1603, !tbaa !778
  %59 = load i8* %35, align 1, !dbg !1604, !tbaa !773
  %60 = icmp eq i8 %59, 0, !dbg !1604
  br i1 %60, label %77, label %.lr.ph, !dbg !1604

.lr.ph:                                           ; preds = %51
  %61 = add i64 %45, 2, !dbg !1605
  %62 = zext i1 %52 to i64, !dbg !1606
  %.sum = add i64 %62, %45, !dbg !1606
  br label %63, !dbg !1604

; <label>:63                                      ; preds = %.lr.ph, %63
  %namep.05 = phi i8* [ %35, %.lr.ph ], [ %72, %63 ]
  %file.04 = phi i8* [ null, %.lr.ph ], [ %66, %63 ]
  %status.03 = phi i32 [ 1, %.lr.ph ], [ %74, %63 ]
  %64 = call i64 @strlen(i8* %namep.05) #12, !dbg !1607
  call void @llvm.dbg.value(metadata !{i64 %64}, i64 0, metadata !479), !dbg !1607
  %65 = add i64 %61, %64, !dbg !1605
  %66 = call i8* @xrealloc(i8* %file.04, i64 %65) #8, !dbg !1605
  call void @llvm.dbg.value(metadata !{i8* %66}, i64 0, metadata !476), !dbg !1605
  %67 = call i8* @strcpy(i8* %66, i8* %dir) #8, !dbg !1608
  %68 = getelementptr inbounds i8* %66, i64 %45, !dbg !1609
  store i8 47, i8* %68, align 1, !dbg !1609, !tbaa !773
  %69 = getelementptr inbounds i8* %66, i64 %.sum, !dbg !1606
  %70 = call i8* @strcpy(i8* %69, i8* %namep.05) #8, !dbg !1606
  %71 = add i64 %64, 1, !dbg !1610
  %72 = getelementptr inbounds i8* %namep.05, i64 %71, !dbg !1610
  call void @llvm.dbg.value(metadata !{i8* %72}, i64 0, metadata !477), !dbg !1610
  %73 = call fastcc i32 @grepfile(i8* %66, %struct.stats* %child), !dbg !1611
  %74 = and i32 %73, %status.03, !dbg !1611
  call void @llvm.dbg.value(metadata !{i32 %74}, i64 0, metadata !471), !dbg !1611
  %75 = load i8* %72, align 1, !dbg !1604, !tbaa !773
  %76 = icmp eq i8 %75, 0, !dbg !1604
  br i1 %76, label %._crit_edge, label %63, !dbg !1604

._crit_edge:                                      ; preds = %63
  %.b.pre = load i1* @no_filenames, align 1
  %.pre = load i32* @out_file, align 4, !dbg !1612, !tbaa !778
  br label %77, !dbg !1604

; <label>:77                                      ; preds = %._crit_edge, %51
  %78 = phi i32 [ %.pre, %._crit_edge ], [ %58, %51 ]
  %.b = phi i1 [ %.b.pre, %._crit_edge ], [ %.b1, %51 ]
  %file.0.lcssa = phi i8* [ %66, %._crit_edge ], [ null, %51 ]
  %status.0.lcssa = phi i32 [ %74, %._crit_edge ], [ 1, %51 ]
  %79 = zext i1 %.b to i32, !dbg !1612
  %80 = xor i32 %79, 1, !dbg !1612
  %81 = sub nsw i32 %78, %80, !dbg !1612
  store i32 %81, i32* @out_file, align 4, !dbg !1612, !tbaa !778
  call void @free(i8* %file.0.lcssa) #8, !dbg !1613
  call void @free(i8* %35) #8, !dbg !1614
  call void @llvm.lifetime.end(i64 152, i8* %53) #8, !dbg !1615
  br label %82

; <label>:82                                      ; preds = %suppressible_error.exit, %77, %26, %27, %3
  %.0 = phi i32 [ 1, %3 ], [ 1, %27 ], [ 1, %26 ], [ %status.0.lcssa, %77 ], [ 1, %suppressible_error.exit ]
  ret i32 %.0, !dbg !1616
}

; Function Attrs: nounwind
declare i64 @lseek(i32, i64, i32) #2

declare i32 @close(i32) #3

declare i32 @__overflow(%struct._IO_FILE*, i32) #3

; Function Attrs: nounwind uwtable
define internal fastcc i32 @fillbuf(i64 %save, %struct.stats* nocapture readonly %stats) #6 {
  tail call void @llvm.dbg.value(metadata !{i64 %save}, i64 0, metadata !436), !dbg !1617
  tail call void @llvm.dbg.value(metadata !{%struct.stats* %stats}, i64 0, metadata !437), !dbg !1617
  tail call void @llvm.dbg.value(metadata !769, i64 0, metadata !438), !dbg !1618
  tail call void @llvm.dbg.value(metadata !895, i64 0, metadata !439), !dbg !1619
  %1 = load i8** @buflim, align 8, !dbg !1620, !tbaa !717
  %2 = sub i64 0, %save, !dbg !1620
  %3 = getelementptr inbounds i8* %1, i64 %2, !dbg !1620
  %4 = load i8** @buffer, align 8, !dbg !1620, !tbaa !717
  %5 = ptrtoint i8* %3 to i64, !dbg !1620
  %6 = ptrtoint i8* %4 to i64, !dbg !1620
  %7 = sub i64 %5, %6, !dbg !1620
  tail call void @llvm.dbg.value(metadata !{i64 %7}, i64 0, metadata !442), !dbg !1620
  %8 = load i64* @pagesize, align 8, !dbg !1621, !tbaa !775
  %9 = load i64* @bufalloc, align 8, !dbg !1621, !tbaa !775
  %10 = getelementptr inbounds i8* %4, i64 %9, !dbg !1621
  %11 = ptrtoint i8* %10 to i64, !dbg !1621
  %12 = ptrtoint i8* %1 to i64, !dbg !1621
  %13 = sub i64 %11, %12, !dbg !1621
  %14 = icmp ugt i64 %8, %13, !dbg !1621
  br i1 %14, label %16, label %15, !dbg !1621

; <label>:15                                      ; preds = %0
  tail call void @llvm.dbg.value(metadata !{i8* %1}, i64 0, metadata !440), !dbg !1622
  store i8* %3, i8** @bufbeg, align 8, !dbg !1624, !tbaa !717
  br label %72, !dbg !1625

; <label>:16                                      ; preds = %0
  %17 = add i64 %8, %save, !dbg !1626
  tail call void @llvm.dbg.value(metadata !{i64 %17}, i64 0, metadata !443), !dbg !1626
  %18 = xor i64 %8, -1, !dbg !1627
  %19 = add i64 %9, %18, !dbg !1627
  tail call void @llvm.dbg.value(metadata !{i64 %19}, i64 0, metadata !446), !dbg !1627
  br label %20, !dbg !1627

; <label>:20                                      ; preds = %25, %16
  %newsize.0 = phi i64 [ %19, %16 ], [ %23, %25 ]
  %21 = icmp ult i64 %newsize.0, %17, !dbg !1627
  br i1 %21, label %22, label %30, !dbg !1627

; <label>:22                                      ; preds = %20
  %23 = shl i64 %newsize.0, 1, !dbg !1629
  %24 = icmp ult i64 %23, %newsize.0, !dbg !1629
  br i1 %24, label %29, label %25, !dbg !1629

; <label>:25                                      ; preds = %22
  %26 = or i64 %23, 1, !dbg !1629
  %27 = add i64 %26, %8, !dbg !1629
  %28 = icmp ult i64 %27, %23, !dbg !1629
  br i1 %28, label %29, label %20, !dbg !1629

; <label>:29                                      ; preds = %25, %22
  tail call void @xalloc_die() #11, !dbg !1631
  unreachable, !dbg !1631

; <label>:30                                      ; preds = %20
  %31 = getelementptr inbounds %struct.stats* %stats, i64 0, i32 1, i32 3, !dbg !1632
  %32 = load i32* %31, align 4, !dbg !1632, !tbaa !1269
  %33 = and i32 %32, 61440, !dbg !1632
  %34 = icmp eq i32 %33, 32768, !dbg !1632
  br i1 %34, label %35, label %45, !dbg !1632

; <label>:35                                      ; preds = %30
  %36 = getelementptr inbounds %struct.stats* %stats, i64 0, i32 1, i32 8, !dbg !1633
  %37 = load i64* %36, align 8, !dbg !1633, !tbaa !1584
  %38 = load i64* @bufoffset, align 8, !dbg !1633, !tbaa !775
  %39 = sub nsw i64 %37, %38, !dbg !1633
  tail call void @llvm.dbg.value(metadata !{i64 %39}, i64 0, metadata !449), !dbg !1633
  %40 = add i64 %39, %save, !dbg !1634
  tail call void @llvm.dbg.value(metadata !{i64 %40}, i64 0, metadata !452), !dbg !1634
  %41 = icmp slt i64 %39, 0, !dbg !1635
  %42 = icmp sgt i64 %39, %40, !dbg !1635
  %or.cond = or i1 %41, %42, !dbg !1635
  %43 = icmp ugt i64 %17, %40, !dbg !1635
  %or.cond2 = or i1 %or.cond, %43, !dbg !1635
  %or.cond2.not = xor i1 %or.cond2, true, !dbg !1635
  %44 = icmp ult i64 %40, %newsize.0, !dbg !1635
  %or.cond3 = and i1 %44, %or.cond2.not, !dbg !1635
  tail call void @llvm.dbg.value(metadata !{i64 %40}, i64 0, metadata !446), !dbg !1637
  %.newsize.0 = select i1 %or.cond3, i64 %40, i64 %newsize.0, !dbg !1635
  br label %45, !dbg !1635

; <label>:45                                      ; preds = %35, %30
  %newsize.1 = phi i64 [ %newsize.0, %30 ], [ %.newsize.0, %35 ]
  %46 = add i64 %newsize.1, 1, !dbg !1638
  %47 = add i64 %46, %8, !dbg !1638
  tail call void @llvm.dbg.value(metadata !{i64 %47}, i64 0, metadata !447), !dbg !1638
  %48 = icmp ult i64 %9, %47, !dbg !1639
  br i1 %48, label %49, label %51, !dbg !1639

; <label>:49                                      ; preds = %45
  store i64 %47, i64* @bufalloc, align 8, !dbg !1639, !tbaa !775
  %50 = tail call noalias i8* @xmalloc(i64 %47) #8, !dbg !1639
  %.pre = load i64* @pagesize, align 8, !dbg !1640, !tbaa !775
  br label %51, !dbg !1639

; <label>:51                                      ; preds = %45, %49
  %52 = phi i64 [ %.pre, %49 ], [ %8, %45 ]
  %53 = phi i8* [ %50, %49 ], [ %4, %45 ], !dbg !1639
  tail call void @llvm.dbg.value(metadata !{i8* %53}, i64 0, metadata !448), !dbg !1639
  %.sum = add i64 %save, 1, !dbg !1640
  %54 = getelementptr inbounds i8* %53, i64 %.sum, !dbg !1640
  %55 = ptrtoint i8* %54 to i64, !dbg !1640
  %56 = urem i64 %55, %52, !dbg !1640
  %57 = icmp eq i64 %56, 0, !dbg !1640
  br i1 %57, label %61, label %58, !dbg !1640

; <label>:58                                      ; preds = %51
  %59 = add i64 %52, %.sum, !dbg !1640
  %.sum1 = sub i64 %59, %56, !dbg !1640
  %60 = getelementptr inbounds i8* %53, i64 %.sum1, !dbg !1640
  br label %61, !dbg !1640

; <label>:61                                      ; preds = %51, %58
  %62 = phi i8* [ %60, %58 ], [ %54, %51 ], !dbg !1640
  tail call void @llvm.dbg.value(metadata !{i8* %62}, i64 0, metadata !440), !dbg !1640
  %63 = getelementptr inbounds i8* %62, i64 %2, !dbg !1641
  store i8* %63, i8** @bufbeg, align 8, !dbg !1641, !tbaa !717
  %64 = load i8** @buffer, align 8, !dbg !1642, !tbaa !717
  %65 = getelementptr inbounds i8* %64, i64 %7, !dbg !1642
  tail call void @llvm.memmove.p0i8.p0i8.i64(i8* %63, i8* %65, i64 %save, i32 1, i1 false), !dbg !1642
  %66 = load i8* @eolbyte, align 1, !dbg !1643, !tbaa !773
  %67 = load i8** @bufbeg, align 8, !dbg !1643, !tbaa !717
  %68 = getelementptr inbounds i8* %67, i64 -1, !dbg !1643
  store i8 %66, i8* %68, align 1, !dbg !1643, !tbaa !773
  %69 = load i8** @buffer, align 8, !dbg !1644, !tbaa !717
  %70 = icmp eq i8* %53, %69, !dbg !1644
  br i1 %70, label %72, label %71, !dbg !1644

; <label>:71                                      ; preds = %61
  tail call void @free(i8* %69) #8, !dbg !1646
  store i8* %53, i8** @buffer, align 8, !dbg !1648, !tbaa !717
  br label %72, !dbg !1649

; <label>:72                                      ; preds = %61, %71, %15
  %73 = phi i8* [ %4, %15 ], [ %53, %71 ], [ %53, %61 ]
  %readbuf.0 = phi i8* [ %1, %15 ], [ %62, %71 ], [ %62, %61 ]
  %74 = load i64* @bufalloc, align 8, !dbg !1650, !tbaa !775
  %75 = getelementptr inbounds i8* %73, i64 %74, !dbg !1650
  %76 = ptrtoint i8* %75 to i64, !dbg !1650
  %77 = ptrtoint i8* %readbuf.0 to i64, !dbg !1650
  %78 = sub i64 %76, %77, !dbg !1650
  tail call void @llvm.dbg.value(metadata !{i64 %78}, i64 0, metadata !441), !dbg !1650
  %79 = load i64* @pagesize, align 8, !dbg !1651, !tbaa !775
  %80 = urem i64 %78, %79, !dbg !1651
  %81 = sub i64 %78, %80, !dbg !1651
  tail call void @llvm.dbg.value(metadata !{i64 %81}, i64 0, metadata !441), !dbg !1651
  br label %82, !dbg !1652

; <label>:82                                      ; preds = %72, %86
  %83 = load i32* @bufdesc, align 4, !dbg !1653, !tbaa !778
  %84 = tail call i64 @read(i32 %83, i8* %readbuf.0, i64 %81) #8, !dbg !1653
  %85 = icmp slt i64 %84, 0, !dbg !1653
  br i1 %85, label %86, label %.critedge, !dbg !1653

; <label>:86                                      ; preds = %82
  %87 = tail call i32* @__errno_location() #1, !dbg !1654
  %88 = load i32* %87, align 4, !dbg !1654, !tbaa !778
  %89 = icmp eq i32 %88, 4, !dbg !1654
  br i1 %89, label %82, label %.critedge

.critedge:                                        ; preds = %82, %86
  %.lcssa8 = phi i64 [ %84, %82 ], [ 0, %86 ]
  %.lobit = lshr i64 %84, 63, !dbg !1655
  %90 = trunc i64 %.lobit to i32, !dbg !1655
  %. = xor i32 %90, 1, !dbg !1655
  %91 = load i64* @bufoffset, align 8, !dbg !1657, !tbaa !775
  %92 = add i64 %91, %.lcssa8, !dbg !1657
  store i64 %92, i64* @bufoffset, align 8, !dbg !1657, !tbaa !775
  %93 = getelementptr inbounds i8* %readbuf.0, i64 %.lcssa8, !dbg !1658
  store i8* %93, i8** @buflim, align 8, !dbg !1658, !tbaa !717
  ret i32 %., !dbg !1659
}

; Function Attrs: nounwind readonly
declare i8* @memchr(i8*, i32, i64) #5

; Function Attrs: nounwind uwtable
define internal fastcc i32 @grepbuf(i8* %beg, i8* %lim) #6 {
  %n = alloca i32, align 4
  %match_size = alloca i64, align 8
  call void @llvm.dbg.value(metadata !{i8* %beg}, i64 0, metadata !385), !dbg !1660
  call void @llvm.dbg.value(metadata !{i8* %lim}, i64 0, metadata !386), !dbg !1660
  call void @llvm.dbg.declare(metadata !{i32* %n}, metadata !388), !dbg !1661
  call void @llvm.dbg.declare(metadata !{i64* %match_size}, metadata !391), !dbg !1662
  call void @llvm.dbg.value(metadata !45, i64 0, metadata !387), !dbg !1663
  call void @llvm.dbg.value(metadata !{i8* %beg}, i64 0, metadata !389), !dbg !1664
  %1 = ptrtoint i8* %lim to i64, !dbg !1665
  br label %.outer, !dbg !1665

.outer:                                           ; preds = %41, %59, %0
  %p.0.ph = phi i8* [ %beg, %0 ], [ %36, %59 ], [ %36, %41 ]
  %nlines.0.ph = phi i32 [ 0, %0 ], [ %61, %59 ], [ %42, %41 ]
  br label %2

; <label>:2                                       ; preds = %.outer, %57
  %p.0 = phi i8* [ %36, %57 ], [ %p.0.ph, %.outer ]
  %3 = ptrtoint i8* %p.0 to i64, !dbg !1665
  %4 = sub i64 %1, %3, !dbg !1665
  call void @llvm.dbg.value(metadata !767, i64 0, metadata !1666) #8, !dbg !1667
  %5 = call i64 @__ctype_get_mb_cur_max() #8, !dbg !1668
  %6 = icmp ne i64 %5, 1, !dbg !1668
  %7 = load i32* @match_icase, align 4, !dbg !1668, !tbaa !778
  %8 = icmp ne i32 %7, 0, !dbg !1668
  %or.cond.i = and i1 %6, %8, !dbg !1668
  br i1 %or.cond.i, label %.preheader.i, label %11, !dbg !1668

.preheader.i:                                     ; preds = %2
  %9 = getelementptr inbounds i8* %p.0, i64 %4, !dbg !1670
  %10 = ptrtoint i8* %9 to i64, !dbg !1671
  br label %14, !dbg !1670

; <label>:11                                      ; preds = %2
  %12 = load i64 (i8*, i64, i64*, i8*)** @execute, align 8, !dbg !1672, !tbaa !717
  %13 = call i64 %12(i8* %p.0, i64 %4, i64* %match_size, i8* null) #8, !dbg !1672
  br label %do_execute.exit, !dbg !1672

; <label>:14                                      ; preds = %16, %.preheader.i
  %line_next.0.i = phi i8* [ %line_next.1.i, %16 ], [ %p.0, %.preheader.i ]
  %15 = icmp ult i8* %line_next.0.i, %9, !dbg !1670
  br i1 %15, label %16, label %do_execute.exit.thread, !dbg !1670

; <label>:16                                      ; preds = %14
  call void @llvm.dbg.value(metadata !{i8* %line_next.0.i}, i64 0, metadata !1673) #8, !dbg !1674
  %17 = load i8* @eolbyte, align 1, !dbg !1671, !tbaa !773
  %18 = zext i8 %17 to i32, !dbg !1671
  %19 = ptrtoint i8* %line_next.0.i to i64, !dbg !1671
  %20 = sub i64 %10, %19, !dbg !1671
  %21 = call i8* @memchr(i8* %line_next.0.i, i32 %18, i64 %20) #12, !dbg !1671
  call void @llvm.dbg.value(metadata !{i8* %21}, i64 0, metadata !1675) #8, !dbg !1671
  %22 = icmp eq i8* %21, null, !dbg !1676
  %23 = getelementptr inbounds i8* %21, i64 1, !dbg !1678
  call void @llvm.dbg.value(metadata !{i8* %23}, i64 0, metadata !1679) #8, !dbg !1678
  %line_next.1.i = select i1 %22, i8* %9, i8* %23, !dbg !1676
  %24 = load i64 (i8*, i64, i64*, i8*)** @execute, align 8, !dbg !1680, !tbaa !717
  %25 = ptrtoint i8* %line_next.1.i to i64, !dbg !1680
  %26 = sub i64 %25, %19, !dbg !1680
  %27 = call i64 %24(i8* %line_next.0.i, i64 %26, i64* %match_size, i8* null) #8, !dbg !1680
  call void @llvm.dbg.value(metadata !{i64 %27}, i64 0, metadata !1681) #8, !dbg !1680
  %28 = icmp eq i64 %27, -1, !dbg !1682
  br i1 %28, label %14, label %29, !dbg !1682

; <label>:29                                      ; preds = %16
  %30 = sub i64 %19, %3, !dbg !1684
  %31 = add i64 %30, %27, !dbg !1684
  br label %do_execute.exit, !dbg !1684

do_execute.exit:                                  ; preds = %11, %29
  %.0.i = phi i64 [ %31, %29 ], [ %13, %11 ]
  call void @llvm.dbg.value(metadata !{i64 %.0.i}, i64 0, metadata !390), !dbg !1665
  %32 = icmp eq i64 %.0.i, -1, !dbg !1665
  br i1 %32, label %do_execute.exit.thread, label %33, !dbg !1665

; <label>:33                                      ; preds = %do_execute.exit
  %34 = getelementptr inbounds i8* %p.0, i64 %.0.i, !dbg !1685
  call void @llvm.dbg.value(metadata !{i8* %34}, i64 0, metadata !392), !dbg !1685
  call void @llvm.dbg.value(metadata !{i64* %match_size}, i64 0, metadata !391), !dbg !1686
  %35 = load i64* %match_size, align 8, !dbg !1686, !tbaa !775
  %.sum = add i64 %35, %.0.i, !dbg !1686
  %36 = getelementptr inbounds i8* %p.0, i64 %.sum, !dbg !1686
  call void @llvm.dbg.value(metadata !{i8* %36}, i64 0, metadata !394), !dbg !1686
  %37 = icmp eq i8* %34, %lim, !dbg !1687
  br i1 %37, label %do_execute.exit.thread, label %38, !dbg !1687

; <label>:38                                      ; preds = %33
  %39 = load i32* @out_invert, align 4, !dbg !1689, !tbaa !778
  %40 = icmp eq i32 %39, 0, !dbg !1689
  br i1 %40, label %41, label %57, !dbg !1689

; <label>:41                                      ; preds = %38
  call fastcc void @prtext(i8* %34, i8* %36, i32* null), !dbg !1691
  %42 = add nsw i32 %nlines.0.ph, 1, !dbg !1693
  call void @llvm.dbg.value(metadata !{i32 %42}, i64 0, metadata !387), !dbg !1693
  %43 = load i64* @outleft, align 8, !dbg !1694, !tbaa !775
  %44 = add nsw i64 %43, -1, !dbg !1694
  store i64 %44, i64* @outleft, align 8, !dbg !1694, !tbaa !775
  %45 = icmp eq i64 %44, 0, !dbg !1695
  %46 = load i32* @done_on_match, align 4, !dbg !1695, !tbaa !778
  %47 = icmp ne i32 %46, 0, !dbg !1695
  %or.cond = or i1 %45, %47, !dbg !1695
  br i1 %or.cond, label %48, label %.outer, !dbg !1695

; <label>:48                                      ; preds = %41
  %.b = load i1* @exit_on_match, align 1
  br i1 %.b, label %49, label %50, !dbg !1697

; <label>:49                                      ; preds = %48
  call void @exit(i32 0) #11, !dbg !1700
  unreachable, !dbg !1700

; <label>:50                                      ; preds = %48
  %51 = load i64* @bufoffset, align 8, !dbg !1701, !tbaa !775
  %52 = load i8** @buflim, align 8, !dbg !1701, !tbaa !717
  %53 = ptrtoint i8* %52 to i64, !dbg !1701
  %54 = ptrtoint i8* %36 to i64, !dbg !1701
  %55 = add i64 %51, %54, !dbg !1701
  %56 = sub i64 %55, %53, !dbg !1701
  store i64 %56, i64* @after_last_match, align 8, !dbg !1701, !tbaa !775
  br label %.loopexit, !dbg !1702

; <label>:57                                      ; preds = %38
  %58 = icmp sgt i64 %.0.i, 0, !dbg !1703
  br i1 %58, label %59, label %2, !dbg !1703

; <label>:59                                      ; preds = %57
  call fastcc void @prtext(i8* %p.0, i8* %34, i32* %n), !dbg !1705
  call void @llvm.dbg.value(metadata !{i32* %n}, i64 0, metadata !388), !dbg !1707
  %60 = load i32* %n, align 4, !dbg !1707, !tbaa !778
  %61 = add nsw i32 %60, %nlines.0.ph, !dbg !1707
  call void @llvm.dbg.value(metadata !{i32 %61}, i64 0, metadata !387), !dbg !1707
  %62 = sext i32 %60 to i64, !dbg !1708
  %63 = load i64* @outleft, align 8, !dbg !1708, !tbaa !775
  %64 = sub nsw i64 %63, %62, !dbg !1708
  store i64 %64, i64* @outleft, align 8, !dbg !1708, !tbaa !775
  %65 = icmp eq i64 %63, %62, !dbg !1709
  br i1 %65, label %.loopexit, label %.outer, !dbg !1709

do_execute.exit.thread:                           ; preds = %do_execute.exit, %33, %14
  %66 = load i32* @out_invert, align 4, !dbg !1711, !tbaa !778
  %67 = icmp ne i32 %66, 0, !dbg !1711
  %68 = icmp ult i8* %p.0, %lim, !dbg !1711
  %or.cond2 = and i1 %67, %68, !dbg !1711
  br i1 %or.cond2, label %69, label %.loopexit, !dbg !1711

; <label>:69                                      ; preds = %do_execute.exit.thread
  call fastcc void @prtext(i8* %p.0, i8* %lim, i32* %n), !dbg !1713
  call void @llvm.dbg.value(metadata !{i32* %n}, i64 0, metadata !388), !dbg !1715
  %70 = load i32* %n, align 4, !dbg !1715, !tbaa !778
  %71 = add nsw i32 %70, %nlines.0.ph, !dbg !1715
  call void @llvm.dbg.value(metadata !{i32 %71}, i64 0, metadata !387), !dbg !1715
  %72 = sext i32 %70 to i64, !dbg !1716
  %73 = load i64* @outleft, align 8, !dbg !1716, !tbaa !775
  %74 = sub nsw i64 %73, %72, !dbg !1716
  store i64 %74, i64* @outleft, align 8, !dbg !1716, !tbaa !775
  br label %.loopexit, !dbg !1717

.loopexit:                                        ; preds = %59, %69, %do_execute.exit.thread, %50
  %.0 = phi i32 [ %42, %50 ], [ %71, %69 ], [ %nlines.0.ph, %do_execute.exit.thread ], [ %61, %59 ]
  ret i32 %.0, !dbg !1718
}

; Function Attrs: nounwind uwtable
define internal fastcc void @prpending(i8* %lim) #6 {
  %match_size = alloca i64, align 8
  call void @llvm.dbg.value(metadata !{i8* %lim}, i64 0, metadata !317), !dbg !1719
  %1 = load i8** @lastout, align 8, !dbg !1720, !tbaa !717
  %2 = icmp eq i8* %1, null, !dbg !1720
  br i1 %2, label %3, label %thread-pre-split.preheader, !dbg !1720

; <label>:3                                       ; preds = %0
  %4 = load i8** @bufbeg, align 8, !dbg !1722, !tbaa !717
  store i8* %4, i8** @lastout, align 8, !dbg !1722, !tbaa !717
  br label %thread-pre-split.preheader, !dbg !1722

thread-pre-split.preheader:                       ; preds = %0, %3
  %.pr1 = load i32* @pending, align 4, !dbg !1723, !tbaa !778
  %5 = icmp sgt i32 %.pr1, 0, !dbg !1723
  br i1 %5, label %.lr.ph.lr.ph, label %.critedge, !dbg !1723

.lr.ph.lr.ph:                                     ; preds = %thread-pre-split.preheader
  %6 = ptrtoint i8* %lim to i64, !dbg !1724
  br label %.lr.ph, !dbg !1723

.lr.ph:                                           ; preds = %thread-pre-split, %.lr.ph.lr.ph
  %.pr2 = phi i32 [ %.pr1, %.lr.ph.lr.ph ], [ %.pr, %thread-pre-split ]
  %7 = load i8** @lastout, align 8, !dbg !1723, !tbaa !717
  %8 = icmp ult i8* %7, %lim, !dbg !1723
  br i1 %8, label %9, label %.critedge

; <label>:9                                       ; preds = %.lr.ph
  %10 = load i8* @eolbyte, align 1, !dbg !1724, !tbaa !773
  %11 = zext i8 %10 to i32, !dbg !1724
  %12 = ptrtoint i8* %7 to i64, !dbg !1724
  %13 = sub i64 %6, %12, !dbg !1724
  %14 = call i8* @memchr(i8* %7, i32 %11, i64 %13) #12, !dbg !1724
  call void @llvm.dbg.value(metadata !{i8* %14}, i64 0, metadata !318), !dbg !1724
  call void @llvm.dbg.declare(metadata !{i64* %match_size}, metadata !320), !dbg !1725
  %15 = add nsw i32 %.pr2, -1, !dbg !1726
  store i32 %15, i32* @pending, align 4, !dbg !1726, !tbaa !778
  %16 = load i64* @outleft, align 8, !dbg !1727, !tbaa !775
  %17 = icmp eq i64 %16, 0, !dbg !1727
  br i1 %17, label %18, label %.thread-pre-split_crit_edge4, !dbg !1727

.thread-pre-split_crit_edge4:                     ; preds = %9
  %.pre5 = getelementptr inbounds i8* %14, i64 1, !dbg !1729
  br label %thread-pre-split, !dbg !1727

; <label>:18                                      ; preds = %9
  %19 = load i64 (i8*, i64, i64*, i8*)** @execute, align 8, !dbg !1730, !tbaa !717
  %20 = getelementptr inbounds i8* %14, i64 1, !dbg !1730
  %21 = ptrtoint i8* %20 to i64, !dbg !1730
  %22 = sub i64 %21, %12, !dbg !1730
  %23 = call i64 %19(i8* %7, i64 %22, i64* %match_size, i8* null) #8, !dbg !1730
  %24 = icmp eq i64 %23, -1, !dbg !1730
  %25 = load i32* @out_invert, align 4, !dbg !1730, !tbaa !778
  %26 = icmp eq i32 %25, 0, !dbg !1730
  %tmp = xor i1 %24, %26, !dbg !1730
  br i1 %tmp, label %..critedge_crit_edge, label %.thread-pre-split_crit_edge, !dbg !1730

.thread-pre-split_crit_edge:                      ; preds = %18
  %.pre = load i8** @lastout, align 8, !dbg !1729, !tbaa !717
  br label %thread-pre-split, !dbg !1730

thread-pre-split:                                 ; preds = %.thread-pre-split_crit_edge4, %.thread-pre-split_crit_edge
  %.pre-phi = phi i8* [ %.pre5, %.thread-pre-split_crit_edge4 ], [ %20, %.thread-pre-split_crit_edge ], !dbg !1729
  %27 = phi i8* [ %7, %.thread-pre-split_crit_edge4 ], [ %.pre, %.thread-pre-split_crit_edge ]
  call fastcc void @prline(i8* %27, i8* %.pre-phi, i32 45), !dbg !1729
  %.pr = load i32* @pending, align 4, !dbg !1723, !tbaa !778
  %28 = icmp sgt i32 %.pr, 0, !dbg !1723
  br i1 %28, label %.lr.ph, label %.critedge, !dbg !1723

..critedge_crit_edge:                             ; preds = %18
  store i32 0, i32* @pending, align 4, !dbg !1731, !tbaa !778
  br label %.critedge, !dbg !1723

.critedge:                                        ; preds = %thread-pre-split, %.lr.ph, %thread-pre-split.preheader, %..critedge_crit_edge
  ret void, !dbg !1732
}

; Function Attrs: nounwind uwtable
define internal fastcc void @prline(i8* %beg, i8* %lim, i32 %sep) #6 {
  %match_size.i = alloca i64, align 8
  call void @llvm.dbg.value(metadata !{i8* %beg}, i64 0, metadata !325), !dbg !1733
  call void @llvm.dbg.value(metadata !{i8* %lim}, i64 0, metadata !326), !dbg !1733
  call void @llvm.dbg.value(metadata !{i32 %sep}, i64 0, metadata !327), !dbg !1733
  %.b5 = load i1* @only_matching, align 1
  br i1 %.b5, label %2, label %1, !dbg !1734

; <label>:1                                       ; preds = %0
  call fastcc void @print_line_head(i8* %beg, i8* %lim, i32 %sep), !dbg !1736
  br label %2, !dbg !1736

; <label>:2                                       ; preds = %1, %0
  %3 = icmp eq i32 %sep, 58, !dbg !1737
  %4 = load i32* @out_invert, align 4, !dbg !1737, !tbaa !778
  %5 = icmp ne i32 %4, 0, !dbg !1737
  %6 = xor i1 %3, %5, !dbg !1737
  %7 = load i32* @color_option, align 4, !dbg !1738, !tbaa !778
  %8 = icmp eq i32 %7, 0, !dbg !1738
  br i1 %8, label %18, label %9, !dbg !1738

; <label>:9                                       ; preds = %2
  %10 = icmp slt i32 %7, 0, !dbg !1740
  %. = and i1 %5, %10, !dbg !1740
  %11 = xor i1 %3, %.
  %12 = load i8** @selected_line_color, align 8, !tbaa !717
  %13 = load i8** @context_line_color, align 8, !tbaa !717
  %14 = select i1 %11, i8* %12, i8* %13
  call void @llvm.dbg.value(metadata !{i8* %14}, i64 0, metadata !329), !dbg !1742
  %15 = load i8** @selected_match_color, align 8, !dbg !1743, !tbaa !717
  %16 = load i8** @context_match_color, align 8, !dbg !1743, !tbaa !717
  %17 = select i1 %3, i8* %15, i8* %16, !dbg !1743
  call void @llvm.dbg.value(metadata !{i8* %17}, i64 0, metadata !330), !dbg !1743
  br label %18, !dbg !1744

; <label>:18                                      ; preds = %2, %9
  %line_color.0 = phi i8* [ %14, %9 ], [ null, %2 ]
  %match_color.0 = phi i8* [ %17, %9 ], [ null, %2 ]
  %.b4 = load i1* @only_matching, align 1
  %or.cond = and i1 %.b4, %6, !dbg !1745
  br i1 %or.cond, label %26, label %19, !dbg !1745

; <label>:19                                      ; preds = %18
  br i1 %8, label %print_line_tail.exit, label %20, !dbg !1745

; <label>:20                                      ; preds = %19
  %21 = load i8* %line_color.0, align 1, !dbg !1745, !tbaa !773
  %22 = icmp eq i8 %21, 0, !dbg !1745
  br i1 %22, label %23, label %26, !dbg !1745

; <label>:23                                      ; preds = %20
  %24 = load i8* %match_color.0, align 1, !dbg !1745, !tbaa !773
  %25 = icmp eq i8 %24, 0, !dbg !1745
  br i1 %25, label %print_line_tail.exit, label %26, !dbg !1745

; <label>:26                                      ; preds = %23, %20, %18
  br i1 %6, label %27, label %print_line_middle.exit, !dbg !1747

; <label>:27                                      ; preds = %26
  br i1 %.b4, label %31, label %28, !dbg !1747

; <label>:28                                      ; preds = %27
  %29 = load i8* %match_color.0, align 1, !dbg !1747, !tbaa !773
  %30 = icmp eq i8 %29, 0, !dbg !1747
  br i1 %30, label %print_line_middle.exit.thread13, label %31, !dbg !1747

; <label>:31                                      ; preds = %28, %27
  %32 = bitcast i64* %match_size.i to i8*, !dbg !1750
  call void @llvm.lifetime.start(i64 8, i8* %32) #8, !dbg !1750
  call void @llvm.dbg.value(metadata !{i8* %beg}, i64 0, metadata !1752) #8, !dbg !1750
  call void @llvm.dbg.value(metadata !{i8* %lim}, i64 0, metadata !1753) #8, !dbg !1750
  call void @llvm.dbg.value(metadata !{i8* %line_color.0}, i64 0, metadata !1754) #8, !dbg !1755
  call void @llvm.dbg.value(metadata !{i8* %match_color.0}, i64 0, metadata !1756) #8, !dbg !1755
  call void @llvm.dbg.declare(metadata !{i64* %match_size.i}, metadata !354) #8, !dbg !1757
  call void @llvm.dbg.value(metadata !{i8* %beg}, i64 0, metadata !1758) #8, !dbg !1759
  call void @llvm.dbg.value(metadata !767, i64 0, metadata !1760) #8, !dbg !1761
  %33 = icmp ult i8* %beg, %lim, !dbg !1762
  br i1 %33, label %.lr.ph.i, label %.critedge.i, !dbg !1762

.lr.ph.i:                                         ; preds = %31
  %34 = ptrtoint i8* %lim to i64, !dbg !1763
  %35 = ptrtoint i8* %beg to i64, !dbg !1763
  %36 = sub i64 %34, %35, !dbg !1763
  br label %37, !dbg !1762

; <label>:37                                      ; preds = %95, %.lr.ph.i
  %cur.06.i = phi i8* [ %beg, %.lr.ph.i ], [ %97, %95 ]
  %mid.05.i = phi i8* [ null, %.lr.ph.i ], [ %mid.3.i, %95 ]
  %38 = load i64 (i8*, i64, i64*, i8*)** @execute, align 8, !dbg !1763, !tbaa !717
  %39 = ptrtoint i8* %cur.06.i to i64, !dbg !1763
  %40 = sub i64 %39, %35, !dbg !1763
  %41 = getelementptr inbounds i8* %beg, i64 %40, !dbg !1763
  %42 = call i64 %38(i8* %beg, i64 %36, i64* %match_size.i, i8* %41) #8, !dbg !1763
  call void @llvm.dbg.value(metadata !{i64 %42}, i64 0, metadata !1764) #8, !dbg !1763
  %43 = icmp eq i64 %42, -1, !dbg !1763
  br i1 %43, label %.critedge.i.loopexit, label %44

; <label>:44                                      ; preds = %37
  %45 = getelementptr inbounds i8* %beg, i64 %42, !dbg !1765
  call void @llvm.dbg.value(metadata !{i8* %45}, i64 0, metadata !1766) #8, !dbg !1765
  %46 = icmp eq i8* %45, %lim, !dbg !1767
  br i1 %46, label %.critedge.i.loopexit, label %47, !dbg !1767

; <label>:47                                      ; preds = %44
  call void @llvm.dbg.value(metadata !{i64* %match_size.i}, i64 0, metadata !1769) #8, !dbg !1770
  call void @llvm.dbg.value(metadata !{i64* %match_size.i}, i64 0, metadata !354), !dbg !1770
  %48 = load i64* %match_size.i, align 8, !dbg !1770, !tbaa !775
  %49 = icmp eq i64 %48, 0, !dbg !1770
  br i1 %49, label %50, label %52, !dbg !1770

; <label>:50                                      ; preds = %47
  call void @llvm.dbg.value(metadata !969, i64 0, metadata !1769) #8, !dbg !1772
  call void @llvm.dbg.value(metadata !969, i64 0, metadata !354), !dbg !1772
  store i64 1, i64* %match_size.i, align 8, !dbg !1772, !tbaa !775
  %51 = icmp eq i8* %mid.05.i, null, !dbg !1774
  call void @llvm.dbg.value(metadata !{i8* %cur.0.lcssa.i10}, i64 0, metadata !1760) #8, !dbg !1776
  %cur.0.mid.0.i = select i1 %51, i8* %cur.06.i, i8* %mid.05.i, !dbg !1774
  br label %95, !dbg !1774

; <label>:52                                      ; preds = %47
  %.b2.i = load i1* @only_matching, align 1
  br i1 %.b2.i, label %53, label %57, !dbg !1777

; <label>:53                                      ; preds = %52
  %54 = load i32* @out_invert, align 4, !dbg !1780, !tbaa !778
  %55 = icmp ne i32 %54, 0, !dbg !1780
  %56 = select i1 %55, i32 45, i32 58, !dbg !1780
  call fastcc void @print_line_head(i8* %45, i8* %lim, i32 %56) #8, !dbg !1780
  br label %70, !dbg !1780

; <label>:57                                      ; preds = %52
  %58 = load i8* %line_color.0, align 1, !dbg !1781, !tbaa !773
  %59 = icmp eq i8 %58, 0, !dbg !1781
  br i1 %59, label %63, label %60, !dbg !1781

; <label>:60                                      ; preds = %57
  %61 = load i8** @sgr_start, align 8, !dbg !1781, !tbaa !717
  %62 = call i32 (i8*, ...)* @printf(i8* %61, i8* %line_color.0) #8, !dbg !1781
  br label %63, !dbg !1781

; <label>:63                                      ; preds = %60, %57
  %64 = icmp eq i8* %mid.05.i, null, !dbg !1785
  call void @llvm.dbg.value(metadata !{i8* %mid.0.lcssa.i11}, i64 0, metadata !1758) #8, !dbg !1787
  call void @llvm.dbg.value(metadata !767, i64 0, metadata !1760) #8, !dbg !1789
  %cur.0.mid.03.i = select i1 %64, i8* %cur.06.i, i8* %mid.05.i, !dbg !1785
  %65 = ptrtoint i8* %45 to i64, !dbg !1790
  %66 = ptrtoint i8* %cur.0.mid.03.i to i64, !dbg !1790
  %67 = sub i64 %65, %66, !dbg !1790
  %68 = load %struct._IO_FILE** @stdout, align 8, !dbg !1790, !tbaa !717
  %69 = call i64 @fwrite_unlocked(i8* %cur.0.mid.03.i, i64 1, i64 %67, %struct._IO_FILE* %68) #8, !dbg !1790
  br label %70

; <label>:70                                      ; preds = %63, %53
  %mid.2.i = phi i8* [ %mid.05.i, %53 ], [ null, %63 ]
  %71 = load i32* @color_option, align 4, !dbg !1791, !tbaa !778
  %72 = icmp eq i32 %71, 0, !dbg !1791
  br i1 %72, label %79, label %73, !dbg !1791

; <label>:73                                      ; preds = %70
  %74 = load i8* %match_color.0, align 1, !dbg !1791, !tbaa !773
  %75 = icmp eq i8 %74, 0, !dbg !1791
  br i1 %75, label %79, label %76, !dbg !1791

; <label>:76                                      ; preds = %73
  %77 = load i8** @sgr_start, align 8, !dbg !1791, !tbaa !717
  %78 = call i32 (i8*, ...)* @printf(i8* %77, i8* %match_color.0) #8, !dbg !1791
  br label %79, !dbg !1791

; <label>:79                                      ; preds = %76, %73, %70
  call void @llvm.dbg.value(metadata !{i64* %match_size.i}, i64 0, metadata !1769) #8, !dbg !1794
  call void @llvm.dbg.value(metadata !{i64* %match_size.i}, i64 0, metadata !354), !dbg !1794
  %80 = load i64* %match_size.i, align 8, !dbg !1794, !tbaa !775
  %81 = load %struct._IO_FILE** @stdout, align 8, !dbg !1794, !tbaa !717
  %82 = call i64 @fwrite_unlocked(i8* %45, i64 1, i64 %80, %struct._IO_FILE* %81) #8, !dbg !1794
  %83 = load i32* @color_option, align 4, !dbg !1795, !tbaa !778
  %84 = icmp eq i32 %83, 0, !dbg !1795
  br i1 %84, label %91, label %85, !dbg !1795

; <label>:85                                      ; preds = %79
  %86 = load i8* %match_color.0, align 1, !dbg !1795, !tbaa !773
  %87 = icmp eq i8 %86, 0, !dbg !1795
  br i1 %87, label %91, label %88, !dbg !1795

; <label>:88                                      ; preds = %85
  %89 = load i8** @sgr_end, align 8, !dbg !1795, !tbaa !717
  %90 = call i32 (i8*, ...)* @printf(i8* %89, i8* %match_color.0) #8, !dbg !1795
  br label %91, !dbg !1795

; <label>:91                                      ; preds = %88, %85, %79
  %.b1.i = load i1* @only_matching, align 1
  br i1 %.b1.i, label %92, label %95, !dbg !1798

; <label>:92                                      ; preds = %91
  %93 = load %struct._IO_FILE** @stdout, align 8, !dbg !1800, !tbaa !717
  %94 = call i32 @fputs_unlocked(i8* getelementptr inbounds ([2 x i8]* @.str64, i64 0, i64 0), %struct._IO_FILE* %93) #8, !dbg !1800
  br label %95, !dbg !1800

; <label>:95                                      ; preds = %92, %91, %50
  %mid.3.i = phi i8* [ %mid.2.i, %92 ], [ %mid.2.i, %91 ], [ %cur.0.mid.0.i, %50 ]
  call void @llvm.dbg.value(metadata !{i64* %match_size.i}, i64 0, metadata !1769) #8, !dbg !1801
  call void @llvm.dbg.value(metadata !{i64* %match_size.i}, i64 0, metadata !354), !dbg !1801
  %96 = load i64* %match_size.i, align 8, !dbg !1801, !tbaa !775
  %.sum.i = add i64 %96, %42, !dbg !1801
  %97 = getelementptr inbounds i8* %beg, i64 %.sum.i, !dbg !1801
  call void @llvm.dbg.value(metadata !{i8* %97}, i64 0, metadata !1758) #8, !dbg !1801
  %98 = icmp ult i8* %97, %lim, !dbg !1762
  br i1 %98, label %37, label %.critedge.i.loopexit, !dbg !1762

.critedge.i.loopexit:                             ; preds = %37, %44, %95
  %cur.0.lcssa.i.ph = phi i8* [ %97, %95 ], [ %cur.06.i, %44 ], [ %cur.06.i, %37 ]
  %mid.0.lcssa.i.ph = phi i8* [ %mid.3.i, %95 ], [ %mid.05.i, %44 ], [ %mid.05.i, %37 ]
  %.b.i.pre = load i1* @only_matching, align 1
  br i1 %.b.i.pre, label %print_line_tail.exit.thread, label %99, !dbg !1802

.critedge.i:                                      ; preds = %31
  br i1 %.b4, label %print_line_tail.exit.thread, label %99, !dbg !1802

; <label>:99                                      ; preds = %.critedge.i.loopexit, %.critedge.i
  %mid.0.lcssa.i11 = phi i8* [ %mid.0.lcssa.i.ph, %.critedge.i.loopexit ], [ null, %.critedge.i ]
  %cur.0.lcssa.i10 = phi i8* [ %cur.0.lcssa.i.ph, %.critedge.i.loopexit ], [ %beg, %.critedge.i ]
  %100 = icmp eq i8* %mid.0.lcssa.i11, null, !dbg !1804
  call void @llvm.dbg.value(metadata !{i8* %mid.0.lcssa.i11}, i64 0, metadata !1758) #8, !dbg !1806
  %cur.0.mid.04.i = select i1 %100, i8* %cur.0.lcssa.i10, i8* %mid.0.lcssa.i11, !dbg !1804
  call void @llvm.lifetime.end(i64 8, i8* %32) #8, !dbg !1804
  br label %print_line_middle.exit.thread13, !dbg !1804

print_line_middle.exit:                           ; preds = %26
  br i1 %.b4, label %print_line_tail.exit, label %print_line_middle.exit.thread13, !dbg !1807

print_line_middle.exit.thread13:                  ; preds = %99, %28, %print_line_middle.exit
  %.014 = phi i8* [ %beg, %print_line_middle.exit ], [ %beg, %28 ], [ %cur.0.mid.04.i, %99 ]
  %101 = load i8* %line_color.0, align 1, !dbg !1807, !tbaa !773
  %102 = icmp eq i8 %101, 0, !dbg !1807
  br i1 %102, label %print_line_tail.exit, label %103, !dbg !1807

; <label>:103                                     ; preds = %print_line_middle.exit.thread13
  call void @llvm.dbg.value(metadata !{i8* %.014}, i64 0, metadata !1809) #8, !dbg !1811
  call void @llvm.dbg.value(metadata !{i8* %lim}, i64 0, metadata !1812) #8, !dbg !1811
  call void @llvm.dbg.value(metadata !{i8* %line_color.0}, i64 0, metadata !1813) #8, !dbg !1811
  %104 = icmp ult i8* %.014, %lim, !dbg !1814
  br i1 %104, label %105, label %112, !dbg !1814

; <label>:105                                     ; preds = %103
  %106 = getelementptr inbounds i8* %lim, i64 -1, !dbg !1814
  %107 = load i8* %106, align 1, !dbg !1814, !tbaa !773
  %108 = sext i8 %107 to i32, !dbg !1814
  %109 = load i8* @eolbyte, align 1, !dbg !1814, !tbaa !773
  %110 = zext i8 %109 to i32, !dbg !1814
  %111 = icmp eq i32 %108, %110, !dbg !1814
  br label %112

; <label>:112                                     ; preds = %105, %103
  %113 = phi i1 [ false, %103 ], [ %111, %105 ]
  %114 = zext i1 %113 to i64
  call void @llvm.dbg.value(metadata !{i64 %114}, i64 0, metadata !1815) #8, !dbg !1816
  %115 = sext i1 %113 to i64, !dbg !1817
  %116 = getelementptr inbounds i8* %lim, i64 %115, !dbg !1817
  %117 = icmp ugt i8* %116, %.014, !dbg !1817
  br i1 %117, label %118, label %123, !dbg !1817

; <label>:118                                     ; preds = %112
  %119 = select i1 %113, i64 -2, i64 -1, !dbg !1817
  %120 = getelementptr inbounds i8* %lim, i64 %119, !dbg !1817
  %121 = load i8* %120, align 1, !dbg !1817, !tbaa !773
  %122 = icmp eq i8 %121, 13, !dbg !1817
  br label %123

; <label>:123                                     ; preds = %118, %112
  %124 = phi i1 [ false, %112 ], [ %122, %118 ]
  %125 = zext i1 %124 to i64
  %126 = add i64 %114, %125
  call void @llvm.dbg.value(metadata !{i64 %126}, i64 0, metadata !1815) #8, !dbg !1816
  %127 = sub i64 0, %126, !dbg !1818
  %128 = getelementptr inbounds i8* %lim, i64 %127, !dbg !1818
  %129 = ptrtoint i8* %128 to i64, !dbg !1818
  %130 = ptrtoint i8* %.014 to i64, !dbg !1818
  %131 = sub i64 %129, %130, !dbg !1818
  call void @llvm.dbg.value(metadata !{i64 %131}, i64 0, metadata !1819) #8, !dbg !1818
  %132 = icmp eq i8* %128, %.014, !dbg !1820
  br i1 %132, label %print_line_tail.exit, label %133, !dbg !1820

; <label>:133                                     ; preds = %123
  %134 = load i8** @sgr_start, align 8, !dbg !1822, !tbaa !717
  %135 = call i32 (i8*, ...)* @printf(i8* %134, i8* %line_color.0) #8, !dbg !1822
  %136 = load %struct._IO_FILE** @stdout, align 8, !dbg !1826, !tbaa !717
  %137 = call i64 @fwrite_unlocked(i8* %.014, i64 1, i64 %131, %struct._IO_FILE* %136) #8, !dbg !1826
  %138 = getelementptr inbounds i8* %.014, i64 %131, !dbg !1827
  call void @llvm.dbg.value(metadata !{i8* %138}, i64 0, metadata !1809) #8, !dbg !1827
  %139 = load i8* %line_color.0, align 1, !dbg !1828, !tbaa !773
  %140 = icmp eq i8 %139, 0, !dbg !1828
  br i1 %140, label %print_line_tail.exit, label %141, !dbg !1828

; <label>:141                                     ; preds = %133
  %142 = load i8** @sgr_end, align 8, !dbg !1828, !tbaa !717
  %143 = call i32 (i8*, ...)* @printf(i8* %142, i8* %line_color.0) #8, !dbg !1828
  br label %print_line_tail.exit, !dbg !1828

print_line_tail.exit:                             ; preds = %141, %133, %123, %print_line_middle.exit.thread13, %23, %19, %print_line_middle.exit
  %.1 = phi i8* [ %beg, %print_line_middle.exit ], [ %.014, %print_line_middle.exit.thread13 ], [ %beg, %23 ], [ %beg, %19 ], [ %138, %141 ], [ %138, %133 ], [ %.014, %123 ]
  %.b = load i1* @only_matching, align 1
  %.b.not = xor i1 %.b, true, !dbg !1831
  %144 = icmp ult i8* %.1, %lim, !dbg !1831
  %or.cond7 = and i1 %144, %.b.not, !dbg !1831
  br i1 %or.cond7, label %145, label %print_line_tail.exit.thread, !dbg !1831

; <label>:145                                     ; preds = %print_line_tail.exit
  %146 = ptrtoint i8* %lim to i64, !dbg !1833
  %147 = ptrtoint i8* %.1 to i64, !dbg !1833
  %148 = sub i64 %146, %147, !dbg !1833
  %149 = load %struct._IO_FILE** @stdout, align 8, !dbg !1833, !tbaa !717
  %150 = call i64 @fwrite_unlocked(i8* %.1, i64 1, i64 %148, %struct._IO_FILE* %149) #8, !dbg !1833
  br label %print_line_tail.exit.thread, !dbg !1833

print_line_tail.exit.thread:                      ; preds = %.critedge.i, %.critedge.i.loopexit, %print_line_tail.exit, %145
  %151 = load %struct._IO_FILE** @stdout, align 8, !dbg !1834, !tbaa !717
  tail call void @llvm.dbg.value(metadata !{%struct._IO_FILE* %151}, i64 0, metadata !1836), !dbg !1837
  %152 = getelementptr inbounds %struct._IO_FILE* %151, i64 0, i32 0, !dbg !1838
  %153 = load i32* %152, align 4, !dbg !1838, !tbaa !991
  %.lobit.i = and i32 %153, 32, !dbg !1838
  %154 = icmp eq i32 %.lobit.i, 0, !dbg !1834
  br i1 %154, label %159, label %155, !dbg !1834

; <label>:155                                     ; preds = %print_line_tail.exit.thread
  %156 = call i32* @__errno_location() #1, !dbg !1840
  %157 = load i32* %156, align 4, !dbg !1840, !tbaa !778
  %158 = call i8* @dcgettext(i8* null, i8* getelementptr inbounds ([15 x i8]* @.str63, i64 0, i64 0), i32 5) #8, !dbg !1840
  call void (i32, i32, i8*, ...)* @error(i32 0, i32 %157, i8* %158) #8, !dbg !1840
  br label %159, !dbg !1840

; <label>:159                                     ; preds = %print_line_tail.exit.thread, %155
  store i8* %lim, i8** @lastout, align 8, !dbg !1841, !tbaa !717
  %.b6 = load i1* @line_buffered, align 1
  br i1 %.b6, label %160, label %163, !dbg !1842

; <label>:160                                     ; preds = %159
  %161 = load %struct._IO_FILE** @stdout, align 8, !dbg !1844, !tbaa !717
  %162 = call i32 @fflush_unlocked(%struct._IO_FILE* %161) #8, !dbg !1844
  br label %163, !dbg !1844

; <label>:163                                     ; preds = %160, %159
  ret void, !dbg !1845
}

; Function Attrs: nounwind uwtable
define internal fastcc void @print_line_head(i8* %beg, i8* %lim, i32 %sep) #6 {
  tail call void @llvm.dbg.value(metadata !{i8* %beg}, i64 0, metadata !362), !dbg !1846
  tail call void @llvm.dbg.value(metadata !{i8* %lim}, i64 0, metadata !363), !dbg !1846
  tail call void @llvm.dbg.value(metadata !{i32 %sep}, i64 0, metadata !364), !dbg !1846
  tail call void @llvm.dbg.value(metadata !45, i64 0, metadata !365), !dbg !1847
  %1 = load i32* @out_file, align 4, !dbg !1848, !tbaa !778
  %2 = icmp eq i32 %1, 0, !dbg !1848
  br i1 %2, label %fputc_unlocked.exit, label %3, !dbg !1848

; <label>:3                                       ; preds = %0
  %4 = load i32* @color_option, align 4, !dbg !1850, !tbaa !778
  %5 = icmp eq i32 %4, 0, !dbg !1850
  br i1 %5, label %13, label %6, !dbg !1850

; <label>:6                                       ; preds = %3
  %7 = load i8** @filename_color, align 8, !dbg !1850, !tbaa !717
  %8 = load i8* %7, align 1, !dbg !1850, !tbaa !773
  %9 = icmp eq i8 %8, 0, !dbg !1850
  br i1 %9, label %13, label %10, !dbg !1850

; <label>:10                                      ; preds = %6
  %11 = load i8** @sgr_start, align 8, !dbg !1850, !tbaa !717
  %12 = tail call i32 (i8*, ...)* @printf(i8* %11, i8* %7) #8, !dbg !1850
  br label %13, !dbg !1850

; <label>:13                                      ; preds = %10, %6, %3
  %14 = load i8** @filename, align 8, !dbg !1853, !tbaa !717
  %15 = load %struct._IO_FILE** @stdout, align 8, !dbg !1853, !tbaa !717
  %16 = tail call i32 @fputs_unlocked(i8* %14, %struct._IO_FILE* %15) #8, !dbg !1853
  %17 = load i32* @color_option, align 4, !dbg !1854, !tbaa !778
  %18 = icmp eq i32 %17, 0, !dbg !1854
  br i1 %18, label %print_filename.exit, label %19, !dbg !1854

; <label>:19                                      ; preds = %13
  %20 = load i8** @filename_color, align 8, !dbg !1854, !tbaa !717
  %21 = load i8* %20, align 1, !dbg !1854, !tbaa !773
  %22 = icmp eq i8 %21, 0, !dbg !1854
  br i1 %22, label %print_filename.exit, label %23, !dbg !1854

; <label>:23                                      ; preds = %19
  %24 = load i8** @sgr_end, align 8, !dbg !1854, !tbaa !717
  %25 = tail call i32 (i8*, ...)* @printf(i8* %24, i8* %20) #8, !dbg !1854
  br label %print_filename.exit, !dbg !1854

print_filename.exit:                              ; preds = %13, %19, %23
  %.b = load i1* @filename_mask, align 1
  br i1 %.b, label %fputc_unlocked.exit, label %26, !dbg !1855

; <label>:26                                      ; preds = %print_filename.exit
  %27 = load %struct._IO_FILE** @stdout, align 8, !dbg !1857, !tbaa !717
  tail call void @llvm.dbg.value(metadata !45, i64 0, metadata !1858) #8, !dbg !1859
  tail call void @llvm.dbg.value(metadata !{%struct._IO_FILE* %27}, i64 0, metadata !1860) #8, !dbg !1859
  %28 = getelementptr inbounds %struct._IO_FILE* %27, i64 0, i32 5, !dbg !1861
  %29 = load i8** %28, align 8, !dbg !1861, !tbaa !1525
  %30 = getelementptr inbounds %struct._IO_FILE* %27, i64 0, i32 6, !dbg !1861
  %31 = load i8** %30, align 8, !dbg !1861, !tbaa !1526
  %32 = icmp ult i8* %29, %31, !dbg !1861
  br i1 %32, label %35, label %33, !dbg !1861, !prof !1527

; <label>:33                                      ; preds = %26
  %34 = tail call i32 @__overflow(%struct._IO_FILE* %27, i32 0) #8, !dbg !1861
  br label %fputc_unlocked.exit, !dbg !1861

; <label>:35                                      ; preds = %26
  %36 = getelementptr inbounds i8* %29, i64 1, !dbg !1861
  store i8* %36, i8** %28, align 8, !dbg !1861, !tbaa !1525
  store i8 0, i8* %29, align 1, !dbg !1861, !tbaa !773
  br label %fputc_unlocked.exit, !dbg !1861

fputc_unlocked.exit:                              ; preds = %35, %33, %print_filename.exit, %0
  %pending_sep.0 = phi i32 [ 0, %0 ], [ 1, %print_filename.exit ], [ 0, %33 ], [ 0, %35 ]
  %.b3 = load i1* @out_line, align 1
  br i1 %.b3, label %37, label %100, !dbg !1862

; <label>:37                                      ; preds = %fputc_unlocked.exit
  %38 = load i8** @lastnl, align 8, !dbg !1864, !tbaa !717
  %39 = icmp ult i8* %38, %lim, !dbg !1864
  br i1 %39, label %40, label %63, !dbg !1864

; <label>:40                                      ; preds = %37
  tail call void @llvm.dbg.value(metadata !{i8* %beg}, i64 0, metadata !1867) #8, !dbg !1870
  tail call void @llvm.dbg.value(metadata !769, i64 0, metadata !1871) #8, !dbg !1872
  tail call void @llvm.dbg.value(metadata !{i8* %38}, i64 0, metadata !1873) #8, !dbg !1874
  %41 = icmp ult i8* %38, %beg, !dbg !1874
  br i1 %41, label %.lr.ph.i, label %split3.i, !dbg !1874

.lr.ph.i:                                         ; preds = %40
  %42 = load i8* @eolbyte, align 1, !dbg !1875, !tbaa !773
  %43 = zext i8 %42 to i32, !dbg !1875
  %44 = ptrtoint i8* %beg to i64, !dbg !1875
  br label %45, !dbg !1874

; <label>:45                                      ; preds = %50, %.lr.ph.i
  %beg.02.i = phi i8* [ %38, %.lr.ph.i ], [ %52, %50 ]
  %newlines.01.i = phi i64 [ 0, %.lr.ph.i ], [ %51, %50 ]
  %46 = ptrtoint i8* %beg.02.i to i64, !dbg !1875
  %47 = sub i64 %44, %46, !dbg !1875
  %48 = tail call i8* @memchr(i8* %beg.02.i, i32 %43, i64 %47) #12, !dbg !1875
  tail call void @llvm.dbg.value(metadata !{i8* %48}, i64 0, metadata !1873) #8, !dbg !1875
  %49 = icmp eq i8* %48, null, !dbg !1876
  br i1 %49, label %split3.i, label %50, !dbg !1876

; <label>:50                                      ; preds = %45
  %51 = add i64 %newlines.01.i, 1, !dbg !1877
  tail call void @llvm.dbg.value(metadata !{i64 %51}, i64 0, metadata !1871) #8, !dbg !1877
  %52 = getelementptr inbounds i8* %48, i64 1, !dbg !1874
  tail call void @llvm.dbg.value(metadata !{i8* %52}, i64 0, metadata !1873) #8, !dbg !1874
  %53 = icmp ult i8* %52, %beg, !dbg !1874
  br i1 %53, label %45, label %split3.i, !dbg !1874

split3.i:                                         ; preds = %50, %45, %40
  %newlines.0.lcssa.i = phi i64 [ 0, %40 ], [ %51, %50 ], [ %newlines.01.i, %45 ]
  %54 = load i64* @totalnl, align 8, !dbg !1878, !tbaa !775
  tail call void @llvm.dbg.value(metadata !{i64 %54}, i64 0, metadata !1879) #8, !dbg !1880
  tail call void @llvm.dbg.value(metadata !{i64 %newlines.0.lcssa.i}, i64 0, metadata !1881) #8, !dbg !1880
  %uadd.i.i = tail call { i64, i1 } @llvm.uadd.with.overflow.i64(i64 %54, i64 %newlines.0.lcssa.i) #8, !dbg !1882
  %55 = extractvalue { i64, i1 } %uadd.i.i, 0, !dbg !1882
  tail call void @llvm.dbg.value(metadata !{i64 %55}, i64 0, metadata !1883) #8, !dbg !1882
  %56 = extractvalue { i64, i1 } %uadd.i.i, 1, !dbg !1884
  br i1 %56, label %57, label %nlscan.exit, !dbg !1884

; <label>:57                                      ; preds = %split3.i
  %58 = tail call i8* @dcgettext(i8* null, i8* getelementptr inbounds ([28 x i8]* @.str62, i64 0, i64 0), i32 5) #8, !dbg !1885
  tail call void (i32, i32, i8*, ...)* @error(i32 2, i32 0, i8* %58) #8, !dbg !1885
  br label %nlscan.exit, !dbg !1885

nlscan.exit:                                      ; preds = %split3.i, %57
  store i64 %55, i64* @totalnl, align 8, !dbg !1878, !tbaa !775
  store i8* %beg, i8** @lastnl, align 8, !dbg !1886, !tbaa !717
  tail call void @llvm.dbg.value(metadata !{i64 %55}, i64 0, metadata !1887) #8, !dbg !1889
  tail call void @llvm.dbg.value(metadata !969, i64 0, metadata !1890) #8, !dbg !1889
  %uadd.i = tail call { i64, i1 } @llvm.uadd.with.overflow.i64(i64 %55, i64 1) #8, !dbg !1891
  %59 = extractvalue { i64, i1 } %uadd.i, 0, !dbg !1891
  tail call void @llvm.dbg.value(metadata !{i64 %59}, i64 0, metadata !1892) #8, !dbg !1891
  %60 = extractvalue { i64, i1 } %uadd.i, 1, !dbg !1893
  br i1 %60, label %61, label %add_count.exit, !dbg !1893

; <label>:61                                      ; preds = %nlscan.exit
  %62 = tail call i8* @dcgettext(i8* null, i8* getelementptr inbounds ([28 x i8]* @.str62, i64 0, i64 0), i32 5) #8, !dbg !1894
  tail call void (i32, i32, i8*, ...)* @error(i32 2, i32 0, i8* %62) #8, !dbg !1894
  br label %add_count.exit, !dbg !1894

add_count.exit:                                   ; preds = %nlscan.exit, %61
  store i64 %59, i64* @totalnl, align 8, !dbg !1888, !tbaa !775
  store i8* %lim, i8** @lastnl, align 8, !dbg !1895, !tbaa !717
  br label %63, !dbg !1896

; <label>:63                                      ; preds = %add_count.exit, %37
  %64 = icmp eq i32 %pending_sep.0, 0, !dbg !1897
  br i1 %64, label %print_sep.exit, label %65, !dbg !1897

; <label>:65                                      ; preds = %63
  %66 = load i32* @color_option, align 4, !dbg !1899, !tbaa !778
  %67 = icmp eq i32 %66, 0, !dbg !1899
  br i1 %67, label %75, label %68, !dbg !1899

; <label>:68                                      ; preds = %65
  %69 = load i8** @sep_color, align 8, !dbg !1899, !tbaa !717
  %70 = load i8* %69, align 1, !dbg !1899, !tbaa !773
  %71 = icmp eq i8 %70, 0, !dbg !1899
  br i1 %71, label %75, label %72, !dbg !1899

; <label>:72                                      ; preds = %68
  %73 = load i8** @sgr_start, align 8, !dbg !1899, !tbaa !717
  %74 = tail call i32 (i8*, ...)* @printf(i8* %73, i8* %69) #8, !dbg !1899
  br label %75, !dbg !1899

; <label>:75                                      ; preds = %72, %68, %65
  %sext12 = shl i32 %sep, 24, !dbg !1901
  %76 = ashr exact i32 %sext12, 24, !dbg !1901
  %77 = load %struct._IO_FILE** @stdout, align 8, !dbg !1901, !tbaa !717
  tail call void @llvm.dbg.value(metadata !{i32 %76}, i64 0, metadata !1902) #8, !dbg !1903
  tail call void @llvm.dbg.value(metadata !{%struct._IO_FILE* %77}, i64 0, metadata !1904) #8, !dbg !1903
  %78 = getelementptr inbounds %struct._IO_FILE* %77, i64 0, i32 5, !dbg !1905
  %79 = load i8** %78, align 8, !dbg !1905, !tbaa !1525
  %80 = getelementptr inbounds %struct._IO_FILE* %77, i64 0, i32 6, !dbg !1905
  %81 = load i8** %80, align 8, !dbg !1905, !tbaa !1526
  %82 = icmp ult i8* %79, %81, !dbg !1905
  br i1 %82, label %86, label %83, !dbg !1905, !prof !1527

; <label>:83                                      ; preds = %75
  %84 = and i32 %76, 255, !dbg !1905
  %85 = tail call i32 @__overflow(%struct._IO_FILE* %77, i32 %84) #8, !dbg !1905
  br label %fputc_unlocked.exit8, !dbg !1905

; <label>:86                                      ; preds = %75
  %87 = trunc i32 %76 to i8, !dbg !1905
  %88 = getelementptr inbounds i8* %79, i64 1, !dbg !1905
  store i8* %88, i8** %78, align 8, !dbg !1905, !tbaa !1525
  store i8 %87, i8* %79, align 1, !dbg !1905, !tbaa !773
  br label %fputc_unlocked.exit8, !dbg !1905

fputc_unlocked.exit8:                             ; preds = %83, %86
  %89 = load i32* @color_option, align 4, !dbg !1906, !tbaa !778
  %90 = icmp eq i32 %89, 0, !dbg !1906
  br i1 %90, label %print_sep.exit, label %91, !dbg !1906

; <label>:91                                      ; preds = %fputc_unlocked.exit8
  %92 = load i8** @sep_color, align 8, !dbg !1906, !tbaa !717
  %93 = load i8* %92, align 1, !dbg !1906, !tbaa !773
  %94 = icmp eq i8 %93, 0, !dbg !1906
  br i1 %94, label %print_sep.exit, label %95, !dbg !1906

; <label>:95                                      ; preds = %91
  %96 = load i8** @sgr_end, align 8, !dbg !1906, !tbaa !717
  %97 = tail call i32 (i8*, ...)* @printf(i8* %96, i8* %92) #8, !dbg !1906
  br label %print_sep.exit, !dbg !1906

print_sep.exit:                                   ; preds = %95, %91, %fputc_unlocked.exit8, %63
  %98 = load i64* @totalnl, align 8, !dbg !1907, !tbaa !775
  %99 = load i8** @line_num_color, align 8, !dbg !1907, !tbaa !717
  tail call fastcc void @print_offset(i64 %98, i32 4, i8* %99), !dbg !1907
  tail call void @llvm.dbg.value(metadata !895, i64 0, metadata !365), !dbg !1908
  br label %100, !dbg !1909

; <label>:100                                     ; preds = %print_sep.exit, %fputc_unlocked.exit
  %pending_sep.1 = phi i32 [ 1, %print_sep.exit ], [ %pending_sep.0, %fputc_unlocked.exit ]
  %.b2 = load i1* @out_byte, align 1
  br i1 %.b2, label %101, label %146, !dbg !1910

; <label>:101                                     ; preds = %100
  %102 = load i64* @totalcc, align 8, !dbg !1911, !tbaa !775
  %103 = load i8** @bufbeg, align 8, !dbg !1911, !tbaa !717
  %104 = ptrtoint i8* %beg to i64, !dbg !1911
  %105 = ptrtoint i8* %103 to i64, !dbg !1911
  %106 = sub i64 %104, %105, !dbg !1911
  tail call void @llvm.dbg.value(metadata !{i64 %102}, i64 0, metadata !1912) #8, !dbg !1913
  tail call void @llvm.dbg.value(metadata !{i64 %106}, i64 0, metadata !1914) #8, !dbg !1913
  %uadd.i4 = tail call { i64, i1 } @llvm.uadd.with.overflow.i64(i64 %102, i64 %106) #8, !dbg !1915
  %107 = extractvalue { i64, i1 } %uadd.i4, 0, !dbg !1915
  tail call void @llvm.dbg.value(metadata !{i64 %107}, i64 0, metadata !1916) #8, !dbg !1915
  %108 = extractvalue { i64, i1 } %uadd.i4, 1, !dbg !1917
  br i1 %108, label %109, label %add_count.exit5, !dbg !1917

; <label>:109                                     ; preds = %101
  %110 = tail call i8* @dcgettext(i8* null, i8* getelementptr inbounds ([28 x i8]* @.str62, i64 0, i64 0), i32 5) #8, !dbg !1918
  tail call void (i32, i32, i8*, ...)* @error(i32 2, i32 0, i8* %110) #8, !dbg !1918
  br label %add_count.exit5, !dbg !1918

add_count.exit5:                                  ; preds = %101, %109
  tail call void @llvm.dbg.value(metadata !{i64 %107}, i64 0, metadata !366), !dbg !1911
  %111 = icmp eq i32 %pending_sep.1, 0, !dbg !1919
  br i1 %111, label %.thread, label %112, !dbg !1919

; <label>:112                                     ; preds = %add_count.exit5
  %113 = load i32* @color_option, align 4, !dbg !1921, !tbaa !778
  %114 = icmp eq i32 %113, 0, !dbg !1921
  br i1 %114, label %122, label %115, !dbg !1921

; <label>:115                                     ; preds = %112
  %116 = load i8** @sep_color, align 8, !dbg !1921, !tbaa !717
  %117 = load i8* %116, align 1, !dbg !1921, !tbaa !773
  %118 = icmp eq i8 %117, 0, !dbg !1921
  br i1 %118, label %122, label %119, !dbg !1921

; <label>:119                                     ; preds = %115
  %120 = load i8** @sgr_start, align 8, !dbg !1921, !tbaa !717
  %121 = tail call i32 (i8*, ...)* @printf(i8* %120, i8* %116) #8, !dbg !1921
  br label %122, !dbg !1921

; <label>:122                                     ; preds = %119, %115, %112
  %sext11 = shl i32 %sep, 24, !dbg !1923
  %123 = ashr exact i32 %sext11, 24, !dbg !1923
  %124 = load %struct._IO_FILE** @stdout, align 8, !dbg !1923, !tbaa !717
  tail call void @llvm.dbg.value(metadata !{i32 %123}, i64 0, metadata !1924) #8, !dbg !1925
  tail call void @llvm.dbg.value(metadata !{%struct._IO_FILE* %124}, i64 0, metadata !1926) #8, !dbg !1925
  %125 = getelementptr inbounds %struct._IO_FILE* %124, i64 0, i32 5, !dbg !1927
  %126 = load i8** %125, align 8, !dbg !1927, !tbaa !1525
  %127 = getelementptr inbounds %struct._IO_FILE* %124, i64 0, i32 6, !dbg !1927
  %128 = load i8** %127, align 8, !dbg !1927, !tbaa !1526
  %129 = icmp ult i8* %126, %128, !dbg !1927
  br i1 %129, label %133, label %130, !dbg !1927, !prof !1527

; <label>:130                                     ; preds = %122
  %131 = and i32 %123, 255, !dbg !1927
  %132 = tail call i32 @__overflow(%struct._IO_FILE* %124, i32 %131) #8, !dbg !1927
  br label %fputc_unlocked.exit9, !dbg !1927

; <label>:133                                     ; preds = %122
  %134 = trunc i32 %123 to i8, !dbg !1927
  %135 = getelementptr inbounds i8* %126, i64 1, !dbg !1927
  store i8* %135, i8** %125, align 8, !dbg !1927, !tbaa !1525
  store i8 %134, i8* %126, align 1, !dbg !1927, !tbaa !773
  br label %fputc_unlocked.exit9, !dbg !1927

fputc_unlocked.exit9:                             ; preds = %130, %133
  %136 = load i32* @color_option, align 4, !dbg !1928, !tbaa !778
  %137 = icmp eq i32 %136, 0, !dbg !1928
  br i1 %137, label %.thread, label %138, !dbg !1928

; <label>:138                                     ; preds = %fputc_unlocked.exit9
  %139 = load i8** @sep_color, align 8, !dbg !1928, !tbaa !717
  %140 = load i8* %139, align 1, !dbg !1928, !tbaa !773
  %141 = icmp eq i8 %140, 0, !dbg !1928
  br i1 %141, label %.thread, label %142, !dbg !1928

; <label>:142                                     ; preds = %138
  %143 = load i8** @sgr_end, align 8, !dbg !1928, !tbaa !717
  %144 = tail call i32 (i8*, ...)* @printf(i8* %143, i8* %139) #8, !dbg !1928
  br label %.thread, !dbg !1928

.thread:                                          ; preds = %add_count.exit5, %fputc_unlocked.exit9, %138, %142
  %145 = load i8** @byte_num_color, align 8, !dbg !1929, !tbaa !717
  tail call fastcc void @print_offset(i64 %107, i32 6, i8* %145), !dbg !1929
  tail call void @llvm.dbg.value(metadata !895, i64 0, metadata !365), !dbg !1930
  br label %148, !dbg !1931

; <label>:146                                     ; preds = %100
  %147 = icmp eq i32 %pending_sep.1, 0, !dbg !1931
  br i1 %147, label %print_sep.exit7, label %148, !dbg !1931

; <label>:148                                     ; preds = %.thread, %146
  %.b1 = load i1* @align_tabs, align 1
  br i1 %.b1, label %149, label %152, !dbg !1933

; <label>:149                                     ; preds = %148
  %150 = load %struct._IO_FILE** @stdout, align 8, !dbg !1936, !tbaa !717
  %151 = tail call i32 @fputs_unlocked(i8* getelementptr inbounds ([3 x i8]* @.str65, i64 0, i64 0), %struct._IO_FILE* %150) #8, !dbg !1936
  br label %152, !dbg !1936

; <label>:152                                     ; preds = %149, %148
  %153 = load i32* @color_option, align 4, !dbg !1937, !tbaa !778
  %154 = icmp eq i32 %153, 0, !dbg !1937
  br i1 %154, label %162, label %155, !dbg !1937

; <label>:155                                     ; preds = %152
  %156 = load i8** @sep_color, align 8, !dbg !1937, !tbaa !717
  %157 = load i8* %156, align 1, !dbg !1937, !tbaa !773
  %158 = icmp eq i8 %157, 0, !dbg !1937
  br i1 %158, label %162, label %159, !dbg !1937

; <label>:159                                     ; preds = %155
  %160 = load i8** @sgr_start, align 8, !dbg !1937, !tbaa !717
  %161 = tail call i32 (i8*, ...)* @printf(i8* %160, i8* %156) #8, !dbg !1937
  br label %162, !dbg !1937

; <label>:162                                     ; preds = %159, %155, %152
  %sext = shl i32 %sep, 24, !dbg !1939
  %163 = ashr exact i32 %sext, 24, !dbg !1939
  %164 = load %struct._IO_FILE** @stdout, align 8, !dbg !1939, !tbaa !717
  tail call void @llvm.dbg.value(metadata !{i32 %163}, i64 0, metadata !1940) #8, !dbg !1941
  tail call void @llvm.dbg.value(metadata !{%struct._IO_FILE* %164}, i64 0, metadata !1942) #8, !dbg !1941
  %165 = getelementptr inbounds %struct._IO_FILE* %164, i64 0, i32 5, !dbg !1943
  %166 = load i8** %165, align 8, !dbg !1943, !tbaa !1525
  %167 = getelementptr inbounds %struct._IO_FILE* %164, i64 0, i32 6, !dbg !1943
  %168 = load i8** %167, align 8, !dbg !1943, !tbaa !1526
  %169 = icmp ult i8* %166, %168, !dbg !1943
  br i1 %169, label %173, label %170, !dbg !1943, !prof !1527

; <label>:170                                     ; preds = %162
  %171 = and i32 %163, 255, !dbg !1943
  %172 = tail call i32 @__overflow(%struct._IO_FILE* %164, i32 %171) #8, !dbg !1943
  br label %fputc_unlocked.exit10, !dbg !1943

; <label>:173                                     ; preds = %162
  %174 = trunc i32 %163 to i8, !dbg !1943
  %175 = getelementptr inbounds i8* %166, i64 1, !dbg !1943
  store i8* %175, i8** %165, align 8, !dbg !1943, !tbaa !1525
  store i8 %174, i8* %166, align 1, !dbg !1943, !tbaa !773
  br label %fputc_unlocked.exit10, !dbg !1943

fputc_unlocked.exit10:                            ; preds = %170, %173
  %176 = load i32* @color_option, align 4, !dbg !1944, !tbaa !778
  %177 = icmp eq i32 %176, 0, !dbg !1944
  br i1 %177, label %print_sep.exit7, label %178, !dbg !1944

; <label>:178                                     ; preds = %fputc_unlocked.exit10
  %179 = load i8** @sep_color, align 8, !dbg !1944, !tbaa !717
  %180 = load i8* %179, align 1, !dbg !1944, !tbaa !773
  %181 = icmp eq i8 %180, 0, !dbg !1944
  br i1 %181, label %print_sep.exit7, label %182, !dbg !1944

; <label>:182                                     ; preds = %178
  %183 = load i8** @sgr_end, align 8, !dbg !1944, !tbaa !717
  %184 = tail call i32 (i8*, ...)* @printf(i8* %183, i8* %179) #8, !dbg !1944
  br label %print_sep.exit7, !dbg !1944

print_sep.exit7:                                  ; preds = %182, %178, %fputc_unlocked.exit10, %146
  ret void, !dbg !1945
}

declare i64 @fwrite_unlocked(i8*, i64, i64, %struct._IO_FILE*) #3

declare i32 @fflush_unlocked(%struct._IO_FILE*) #3

; Function Attrs: nounwind uwtable
define internal fastcc void @print_offset(i64 %pos, i32 %min_width, i8* %color) #6 {
  %buf = alloca [64 x i8], align 16
  call void @llvm.dbg.value(metadata !{i64 %pos}, i64 0, metadata !373), !dbg !1946
  call void @llvm.dbg.value(metadata !{i32 %min_width}, i64 0, metadata !374), !dbg !1946
  call void @llvm.dbg.value(metadata !{i8* %color}, i64 0, metadata !375), !dbg !1946
  %1 = getelementptr inbounds [64 x i8]* %buf, i64 0, i64 0, !dbg !1947
  call void @llvm.lifetime.start(i64 64, i8* %1) #8, !dbg !1947
  call void @llvm.dbg.declare(metadata !{[64 x i8]* %buf}, metadata !376), !dbg !1947
  %2 = getelementptr inbounds [64 x i8]* %buf, i64 0, i64 64, !dbg !1948
  call void @llvm.dbg.value(metadata !{i8* %2}, i64 0, metadata !380), !dbg !1948
  br label %3, !dbg !1949

; <label>:3                                       ; preds = %3, %0
  %.01 = phi i32 [ %min_width, %0 ], [ %8, %3 ]
  %.0 = phi i64 [ %pos, %0 ], [ %9, %3 ]
  %p.0 = phi i8* [ %2, %0 ], [ %7, %3 ]
  %4 = urem i64 %.0, 10, !dbg !1950
  %5 = or i64 %4, 48, !dbg !1950
  %6 = trunc i64 %5 to i8, !dbg !1950
  %7 = getelementptr inbounds i8* %p.0, i64 -1, !dbg !1950
  call void @llvm.dbg.value(metadata !{i8* %7}, i64 0, metadata !380), !dbg !1950
  store i8 %6, i8* %7, align 1, !dbg !1950, !tbaa !773
  %8 = add nsw i32 %.01, -1, !dbg !1952
  call void @llvm.dbg.value(metadata !{i32 %8}, i64 0, metadata !374), !dbg !1952
  %9 = udiv i64 %.0, 10, !dbg !1953
  call void @llvm.dbg.value(metadata !{i64 %9}, i64 0, metadata !373), !dbg !1953
  %10 = icmp ugt i64 %.0, 9, !dbg !1953
  br i1 %10, label %3, label %11, !dbg !1953

; <label>:11                                      ; preds = %3
  %.b = load i1* @align_tabs, align 1
  %12 = icmp sgt i32 %8, 0, !dbg !1954
  %or.cond = and i1 %.b, %12, !dbg !1956
  call void @llvm.dbg.value(metadata !{i32 %23}, i64 0, metadata !374), !dbg !1954
  br i1 %or.cond, label %.lr.ph, label %.loopexit, !dbg !1956

.lr.ph:                                           ; preds = %11
  %13 = add i32 %.01, -2, !dbg !1954
  %14 = zext i32 %13 to i64
  %15 = add i32 %.01, -2, !dbg !1954
  %16 = zext i32 %15 to i64
  %17 = add i64 %16, 1, !dbg !1954
  %end.idx = add i64 %16, 1
  %n.vec = and i64 %17, 8589934560
  %cmp.zero = icmp eq i64 %n.vec, 0
  %.not = or i64 %17, -8589934561
  %.sum105 = xor i64 %.not, 8589934560
  %rev.ptr.ind.end = getelementptr i8* %p.0, i64 %.sum105
  %cast.crd = trunc i64 %n.vec to i32
  %rev.ind.end9 = sub i32 %8, %cast.crd
  br i1 %cmp.zero, label %middle.block, label %vector.body

vector.body:                                      ; preds = %.lr.ph, %vector.body
  %index = phi i64 [ %index.next, %vector.body ], [ 0, %.lr.ph ]
  %next.gep.sum = sub i64 -2, %index, !dbg !1957
  %.sum138 = add i64 %next.gep.sum, -15, !dbg !1957
  %18 = getelementptr i8* %p.0, i64 %.sum138, !dbg !1957
  %19 = bitcast i8* %18 to <16 x i8>*, !dbg !1957
  store <16 x i8> <i8 32, i8 32, i8 32, i8 32, i8 32, i8 32, i8 32, i8 32, i8 32, i8 32, i8 32, i8 32, i8 32, i8 32, i8 32, i8 32>, <16 x i8>* %19, align 1, !dbg !1957
  %.sum140 = add i64 %next.gep.sum, -31, !dbg !1957
  %20 = getelementptr i8* %p.0, i64 %.sum140, !dbg !1957
  %21 = bitcast i8* %20 to <16 x i8>*, !dbg !1957
  store <16 x i8> <i8 32, i8 32, i8 32, i8 32, i8 32, i8 32, i8 32, i8 32, i8 32, i8 32, i8 32, i8 32, i8 32, i8 32, i8 32, i8 32>, <16 x i8>* %21, align 1, !dbg !1957
  %index.next = add i64 %index, 32
  %22 = icmp eq i64 %index.next, %n.vec
  br i1 %22, label %middle.block, label %vector.body, !llvm.loop !1958

middle.block:                                     ; preds = %vector.body, %.lr.ph
  %resume.val = phi i8* [ %7, %.lr.ph ], [ %rev.ptr.ind.end, %vector.body ]
  %resume.val8 = phi i32 [ %8, %.lr.ph ], [ %rev.ind.end9, %vector.body ]
  %new.indc.resume.val = phi i64 [ 0, %.lr.ph ], [ %n.vec, %vector.body ]
  %cmp.n = icmp eq i64 %end.idx, %new.indc.resume.val
  br i1 %cmp.n, label %..loopexit_crit_edge, label %scalar.ph

scalar.ph:                                        ; preds = %middle.block, %scalar.ph
  %p.14 = phi i8* [ %24, %scalar.ph ], [ %resume.val, %middle.block ]
  %.13 = phi i32 [ %23, %scalar.ph ], [ %resume.val8, %middle.block ]
  %23 = add nsw i32 %.13, -1, !dbg !1954
  %24 = getelementptr inbounds i8* %p.14, i64 -1, !dbg !1957
  call void @llvm.dbg.value(metadata !{i8* %scevgep}, i64 0, metadata !380), !dbg !1957
  store i8 32, i8* %24, align 1, !dbg !1957, !tbaa !773
  call void @llvm.dbg.value(metadata !{i32 %23}, i64 0, metadata !374), !dbg !1954
  %25 = icmp sgt i32 %23, 0, !dbg !1954
  br i1 %25, label %scalar.ph, label %..loopexit_crit_edge, !dbg !1954, !llvm.loop !1961

..loopexit_crit_edge:                             ; preds = %middle.block, %scalar.ph
  %.sum = sub i64 -2, %14
  %scevgep = getelementptr i8* %p.0, i64 %.sum
  br label %.loopexit, !dbg !1954

.loopexit:                                        ; preds = %..loopexit_crit_edge, %11
  %p.2 = phi i8* [ %7, %11 ], [ %scevgep, %..loopexit_crit_edge ]
  %26 = load i32* @color_option, align 4, !dbg !1962, !tbaa !778
  %27 = icmp eq i32 %26, 0, !dbg !1962
  br i1 %27, label %34, label %28, !dbg !1962

; <label>:28                                      ; preds = %.loopexit
  %29 = load i8* %color, align 1, !dbg !1962, !tbaa !773
  %30 = icmp eq i8 %29, 0, !dbg !1962
  br i1 %30, label %34, label %31, !dbg !1962

; <label>:31                                      ; preds = %28
  %32 = load i8** @sgr_start, align 8, !dbg !1962, !tbaa !717
  %33 = call i32 (i8*, ...)* @printf(i8* %32, i8* %color) #8, !dbg !1962
  br label %34, !dbg !1962

; <label>:34                                      ; preds = %28, %.loopexit, %31
  %35 = ptrtoint i8* %2 to i64, !dbg !1965
  %36 = ptrtoint i8* %p.2 to i64, !dbg !1965
  %37 = sub i64 %35, %36, !dbg !1965
  %38 = load %struct._IO_FILE** @stdout, align 8, !dbg !1965, !tbaa !717
  %39 = call i64 @fwrite_unlocked(i8* %p.2, i64 1, i64 %37, %struct._IO_FILE* %38) #8, !dbg !1965
  %40 = load i32* @color_option, align 4, !dbg !1966, !tbaa !778
  %41 = icmp eq i32 %40, 0, !dbg !1966
  br i1 %41, label %48, label %42, !dbg !1966

; <label>:42                                      ; preds = %34
  %43 = load i8* %color, align 1, !dbg !1966, !tbaa !773
  %44 = icmp eq i8 %43, 0, !dbg !1966
  br i1 %44, label %48, label %45, !dbg !1966

; <label>:45                                      ; preds = %42
  %46 = load i8** @sgr_end, align 8, !dbg !1966, !tbaa !717
  %47 = call i32 (i8*, ...)* @printf(i8* %46, i8* %color) #8, !dbg !1966
  br label %48, !dbg !1966

; <label>:48                                      ; preds = %42, %34, %45
  call void @llvm.lifetime.end(i64 64, i8* %1) #8, !dbg !1969
  ret void, !dbg !1969
}

; Function Attrs: nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #8

; Function Attrs: nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #8

; Function Attrs: nounwind uwtable
define internal fastcc void @prtext(i8* %beg, i8* %lim, i32* %nlinesp) #6 {
  tail call void @llvm.dbg.value(metadata !{i8* %beg}, i64 0, metadata !400), !dbg !1970
  tail call void @llvm.dbg.value(metadata !{i8* %lim}, i64 0, metadata !401), !dbg !1970
  tail call void @llvm.dbg.value(metadata !{i32* %nlinesp}, i64 0, metadata !402), !dbg !1970
  %1 = load i8* @eolbyte, align 1, !dbg !1971, !tbaa !773
  tail call void @llvm.dbg.value(metadata !{i8 %1}, i64 0, metadata !405), !dbg !1971
  %2 = load i32* @out_quiet, align 4, !dbg !1972, !tbaa !778
  %3 = icmp eq i32 %2, 0, !dbg !1972
  %4 = load i32* @pending, align 4, !dbg !1972, !tbaa !778
  %5 = icmp sgt i32 %4, 0, !dbg !1972
  %or.cond = and i1 %3, %5, !dbg !1972
  br i1 %or.cond, label %6, label %7, !dbg !1972

; <label>:6                                       ; preds = %0
  tail call fastcc void @prpending(i8* %beg), !dbg !1974
  %.pr = load i32* @out_quiet, align 4, !dbg !1975, !tbaa !778
  br label %7, !dbg !1974

; <label>:7                                       ; preds = %0, %6
  %8 = phi i32 [ %2, %0 ], [ %.pr, %6 ], !dbg !1975
  tail call void @llvm.dbg.value(metadata !{i8* %beg}, i64 0, metadata !404), !dbg !1976
  %9 = icmp eq i32 %8, 0, !dbg !1975
  br i1 %9, label %10, label %.loopexit, !dbg !1975

; <label>:10                                      ; preds = %7
  %11 = load i8** @lastout, align 8, !dbg !1977, !tbaa !717
  %12 = icmp ne i8* %11, null, !dbg !1977
  %13 = load i8** @bufbeg, align 8, !dbg !1977, !tbaa !717
  %14 = select i1 %12, i8* %11, i8* %13, !dbg !1977
  tail call void @llvm.dbg.value(metadata !{i8* %14}, i64 0, metadata !403), !dbg !1977
  tail call void @llvm.dbg.value(metadata !45, i64 0, metadata !406), !dbg !1978
  %15 = load i32* @out_before, align 4, !dbg !1978, !tbaa !778
  %16 = icmp sgt i32 %15, 0, !dbg !1978
  br i1 %16, label %.lr.ph20, label %._crit_edge, !dbg !1978

.lr.ph20:                                         ; preds = %10, %.loopexit10
  %p.019 = phi i8* [ %p.2, %.loopexit10 ], [ %beg, %10 ]
  %i.018 = phi i32 [ %22, %.loopexit10 ], [ 0, %10 ]
  %17 = icmp ugt i8* %p.019, %14, !dbg !1980
  br i1 %17, label %.preheader9, label %.loopexit10, !dbg !1980

.preheader9:                                      ; preds = %.lr.ph20, %.preheader9
  %p.1 = phi i8* [ %18, %.preheader9 ], [ %p.019, %.lr.ph20 ]
  %18 = getelementptr inbounds i8* %p.1, i64 -1, !dbg !1982
  tail call void @llvm.dbg.value(metadata !{i8* %18}, i64 0, metadata !404), !dbg !1982
  %19 = getelementptr inbounds i8* %p.1, i64 -2, !dbg !1982
  %20 = load i8* %19, align 1, !dbg !1982, !tbaa !773
  %21 = icmp eq i8 %20, %1, !dbg !1982
  br i1 %21, label %.loopexit10, label %.preheader9, !dbg !1982

.loopexit10:                                      ; preds = %.preheader9, %.lr.ph20
  %p.2 = phi i8* [ %p.019, %.lr.ph20 ], [ %18, %.preheader9 ]
  %22 = add nsw i32 %i.018, 1, !dbg !1978
  tail call void @llvm.dbg.value(metadata !{i32 %22}, i64 0, metadata !406), !dbg !1978
  %23 = icmp slt i32 %22, %15, !dbg !1978
  br i1 %23, label %.lr.ph20, label %._crit_edge, !dbg !1978

._crit_edge:                                      ; preds = %.loopexit10, %10
  %p.0.lcssa = phi i8* [ %beg, %10 ], [ %p.2, %.loopexit10 ]
  %24 = load i32* @out_after, align 4, !dbg !1983, !tbaa !778
  %25 = or i32 %24, %15, !dbg !1983
  %26 = icmp ne i32 %25, 0, !dbg !1983
  %.b = load i1* @prtext.used, align 1
  %or.cond6 = and i1 %26, %.b, !dbg !1983
  br i1 %or.cond6, label %27, label %fputc_unlocked.exit.preheader, !dbg !1983

; <label>:27                                      ; preds = %._crit_edge
  %28 = icmp ne i8* %p.0.lcssa, %11, !dbg !1983
  %29 = load i8** @group_separator, align 8, !dbg !1983, !tbaa !717
  %30 = icmp ne i8* %29, null, !dbg !1983
  %or.cond8 = and i1 %28, %30, !dbg !1983
  br i1 %or.cond8, label %31, label %fputc_unlocked.exit.preheader, !dbg !1983

; <label>:31                                      ; preds = %27
  %32 = load i32* @color_option, align 4, !dbg !1985, !tbaa !778
  %33 = icmp eq i32 %32, 0, !dbg !1985
  br i1 %33, label %41, label %34, !dbg !1985

; <label>:34                                      ; preds = %31
  %35 = load i8** @sep_color, align 8, !dbg !1985, !tbaa !717
  %36 = load i8* %35, align 1, !dbg !1985, !tbaa !773
  %37 = icmp eq i8 %36, 0, !dbg !1985
  br i1 %37, label %41, label %38, !dbg !1985

; <label>:38                                      ; preds = %34
  %39 = load i8** @sgr_start, align 8, !dbg !1985, !tbaa !717
  %40 = tail call i32 (i8*, ...)* @printf(i8* %39, i8* %35) #8, !dbg !1985
  %.pre = load i8** @group_separator, align 8, !dbg !1989, !tbaa !717
  br label %41, !dbg !1985

; <label>:41                                      ; preds = %34, %31, %38
  %42 = phi i8* [ %29, %34 ], [ %29, %31 ], [ %.pre, %38 ]
  %43 = load %struct._IO_FILE** @stdout, align 8, !dbg !1989, !tbaa !717
  %44 = tail call i32 @fputs_unlocked(i8* %42, %struct._IO_FILE* %43) #8, !dbg !1989
  %45 = load i32* @color_option, align 4, !dbg !1990, !tbaa !778
  %46 = icmp eq i32 %45, 0, !dbg !1990
  br i1 %46, label %54, label %47, !dbg !1990

; <label>:47                                      ; preds = %41
  %48 = load i8** @sep_color, align 8, !dbg !1990, !tbaa !717
  %49 = load i8* %48, align 1, !dbg !1990, !tbaa !773
  %50 = icmp eq i8 %49, 0, !dbg !1990
  br i1 %50, label %54, label %51, !dbg !1990

; <label>:51                                      ; preds = %47
  %52 = load i8** @sgr_end, align 8, !dbg !1990, !tbaa !717
  %53 = tail call i32 (i8*, ...)* @printf(i8* %52, i8* %48) #8, !dbg !1990
  br label %54, !dbg !1990

; <label>:54                                      ; preds = %47, %41, %51
  %55 = load %struct._IO_FILE** @stdout, align 8, !dbg !1993, !tbaa !717
  tail call void @llvm.dbg.value(metadata !1994, i64 0, metadata !1995) #8, !dbg !1996
  tail call void @llvm.dbg.value(metadata !{%struct._IO_FILE* %55}, i64 0, metadata !1997) #8, !dbg !1996
  %56 = getelementptr inbounds %struct._IO_FILE* %55, i64 0, i32 5, !dbg !1998
  %57 = load i8** %56, align 8, !dbg !1998, !tbaa !1525
  %58 = getelementptr inbounds %struct._IO_FILE* %55, i64 0, i32 6, !dbg !1998
  %59 = load i8** %58, align 8, !dbg !1998, !tbaa !1526
  %60 = icmp ult i8* %57, %59, !dbg !1998
  br i1 %60, label %63, label %61, !dbg !1998, !prof !1527

; <label>:61                                      ; preds = %54
  %62 = tail call i32 @__overflow(%struct._IO_FILE* %55, i32 10) #8, !dbg !1998
  br label %fputc_unlocked.exit.preheader, !dbg !1998

; <label>:63                                      ; preds = %54
  %64 = getelementptr inbounds i8* %57, i64 1, !dbg !1998
  store i8* %64, i8** %56, align 8, !dbg !1998, !tbaa !1525
  store i8 10, i8* %57, align 1, !dbg !1998, !tbaa !773
  br label %fputc_unlocked.exit.preheader, !dbg !1998

fputc_unlocked.exit.preheader:                    ; preds = %._crit_edge, %27, %61, %63
  %65 = icmp ult i8* %p.0.lcssa, %beg, !dbg !1999
  br i1 %65, label %.lr.ph16, label %.loopexit, !dbg !1999

.lr.ph16:                                         ; preds = %fputc_unlocked.exit.preheader
  %66 = sext i8 %1 to i32, !dbg !2000
  %67 = ptrtoint i8* %beg to i64, !dbg !2000
  br label %fputc_unlocked.exit, !dbg !1999

fputc_unlocked.exit:                              ; preds = %.lr.ph16, %fputc_unlocked.exit
  %p.315 = phi i8* [ %p.0.lcssa, %.lr.ph16 ], [ %71, %fputc_unlocked.exit ]
  %68 = ptrtoint i8* %p.315 to i64, !dbg !2000
  %69 = sub i64 %67, %68, !dbg !2000
  %70 = tail call i8* @memchr(i8* %p.315, i32 %66, i64 %69) #12, !dbg !2000
  tail call void @llvm.dbg.value(metadata !{i8* %70}, i64 0, metadata !408), !dbg !2000
  %71 = getelementptr inbounds i8* %70, i64 1, !dbg !2001
  tail call void @llvm.dbg.value(metadata !{i8* %71}, i64 0, metadata !408), !dbg !2001
  tail call fastcc void @prline(i8* %p.315, i8* %71, i32 45), !dbg !2002
  tail call void @llvm.dbg.value(metadata !{i8* %71}, i64 0, metadata !404), !dbg !2003
  %72 = icmp ult i8* %71, %beg, !dbg !1999
  br i1 %72, label %fputc_unlocked.exit, label %.loopexit, !dbg !1999

.loopexit:                                        ; preds = %fputc_unlocked.exit, %fputc_unlocked.exit.preheader, %7
  %p.4 = phi i8* [ %beg, %7 ], [ %p.0.lcssa, %fputc_unlocked.exit.preheader ], [ %71, %fputc_unlocked.exit ]
  %73 = icmp eq i32* %nlinesp, null, !dbg !2004
  br i1 %73, label %98, label %.preheader, !dbg !2004

.preheader:                                       ; preds = %.loopexit
  %74 = icmp ult i8* %p.4, %lim, !dbg !2005
  br i1 %74, label %.lr.ph, label %.critedge, !dbg !2005

.lr.ph:                                           ; preds = %.preheader
  %75 = sext i8 %1 to i32, !dbg !2006
  %76 = ptrtoint i8* %lim to i64, !dbg !2006
  br label %77, !dbg !2005

; <label>:77                                      ; preds = %.lr.ph, %88
  %indvars.iv = phi i64 [ 0, %.lr.ph ], [ %indvars.iv.next, %88 ]
  %p.513 = phi i8* [ %p.4, %.lr.ph ], [ %84, %88 ]
  %78 = load i64* @outleft, align 8, !dbg !2005, !tbaa !775
  %79 = icmp slt i64 %indvars.iv, %78, !dbg !2005
  br i1 %79, label %80, label %.critedgesplit

; <label>:80                                      ; preds = %77
  %81 = ptrtoint i8* %p.513 to i64, !dbg !2006
  %82 = sub i64 %76, %81, !dbg !2006
  %83 = tail call i8* @memchr(i8* %p.513, i32 %75, i64 %82) #12, !dbg !2006
  tail call void @llvm.dbg.value(metadata !{i8* %83}, i64 0, metadata !412), !dbg !2006
  %84 = getelementptr inbounds i8* %83, i64 1, !dbg !2007
  tail call void @llvm.dbg.value(metadata !{i8* %84}, i64 0, metadata !412), !dbg !2007
  %85 = load i32* @out_quiet, align 4, !dbg !2008, !tbaa !778
  %86 = icmp eq i32 %85, 0, !dbg !2008
  br i1 %86, label %87, label %88, !dbg !2008

; <label>:87                                      ; preds = %80
  tail call fastcc void @prline(i8* %p.513, i8* %84, i32 58), !dbg !2010
  br label %88, !dbg !2010

; <label>:88                                      ; preds = %80, %87
  tail call void @llvm.dbg.value(metadata !{i8* %84}, i64 0, metadata !404), !dbg !2011
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1, !dbg !2005
  tail call void @llvm.dbg.value(metadata !{i32 %91}, i64 0, metadata !407), !dbg !2005
  %89 = icmp ult i8* %84, %lim, !dbg !2005
  br i1 %89, label %77, label %..critedge_crit_edge, !dbg !2005

.critedgesplit:                                   ; preds = %77
  %90 = trunc i64 %indvars.iv to i32
  br label %.critedge

..critedge_crit_edge:                             ; preds = %88
  %91 = trunc i64 %indvars.iv.next to i32, !dbg !2005
  br label %.critedge, !dbg !2005

.critedge:                                        ; preds = %.critedgesplit, %..critedge_crit_edge, %.preheader
  %p.5.lcssa = phi i8* [ %84, %..critedge_crit_edge ], [ %p.4, %.preheader ], [ %p.513, %.critedgesplit ]
  %n.0.lcssa = phi i32 [ %91, %..critedge_crit_edge ], [ 0, %.preheader ], [ %90, %.critedgesplit ]
  store i32 %n.0.lcssa, i32* %nlinesp, align 4, !dbg !2012, !tbaa !778
  %92 = load i64* @bufoffset, align 8, !dbg !2013, !tbaa !775
  %93 = load i8** @buflim, align 8, !dbg !2013, !tbaa !717
  %94 = ptrtoint i8* %93 to i64, !dbg !2013
  %95 = ptrtoint i8* %p.5.lcssa to i64, !dbg !2013
  %96 = add i64 %92, %95, !dbg !2013
  %97 = sub i64 %96, %94, !dbg !2013
  store i64 %97, i64* @after_last_match, align 8, !dbg !2013, !tbaa !775
  br label %102, !dbg !2014

; <label>:98                                      ; preds = %.loopexit
  %99 = load i32* @out_quiet, align 4, !dbg !2015, !tbaa !778
  %100 = icmp eq i32 %99, 0, !dbg !2015
  br i1 %100, label %101, label %102, !dbg !2015

; <label>:101                                     ; preds = %98
  tail call fastcc void @prline(i8* %beg, i8* %lim, i32 58), !dbg !2017
  br label %102, !dbg !2017

; <label>:102                                     ; preds = %98, %101, %.critedge
  %103 = load i32* @out_quiet, align 4, !dbg !2018, !tbaa !778
  %104 = icmp ne i32 %103, 0, !dbg !2018
  %105 = load i32* @out_after, align 4, !dbg !2018, !tbaa !778
  %106 = select i1 %104, i32 0, i32 %105, !dbg !2018
  store i32 %106, i32* @pending, align 4, !dbg !2018, !tbaa !778
  store i1 true, i1* @prtext.used, align 1
  ret void, !dbg !2019
}

; Function Attrs: nounwind
declare i64 @__ctype_get_mb_cur_max() #2

; Function Attrs: noreturn
declare void @xalloc_die() #9

; Function Attrs: nounwind
declare void @llvm.memmove.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #8

declare i64 @read(i32, i8* nocapture, i64) #3

; Function Attrs: nounwind readnone
declare i32 @getpagesize() #7

; Function Attrs: noreturn nounwind
declare void @abort() #4

declare i8* @savedir(i8*, i64, %struct.exclude*, %struct.exclude*, %struct.exclude*) #3

; Function Attrs: nounwind
declare i32 @__xstat(i32, i8*, %struct.stat*) #2

; Function Attrs: nounwind uwtable
define internal noalias i8* @color_cap_mt_fct() #6 {
  %1 = load i8** @selected_match_color, align 8, !dbg !2020, !tbaa !717
  store i8* %1, i8** @context_match_color, align 8, !dbg !2020, !tbaa !717
  ret i8* null, !dbg !2021
}

; Function Attrs: nounwind uwtable
define internal noalias i8* @color_cap_rv_fct() #6 {
  store i32 -1, i32* @color_option, align 4, !dbg !2022, !tbaa !778
  ret i8* null, !dbg !2023
}

; Function Attrs: nounwind uwtable
define internal noalias i8* @color_cap_ne_fct() #6 {
  store i8* getelementptr inbounds ([6 x i8]* @.str86, i64 0, i64 0), i8** @sgr_start, align 8, !dbg !2024, !tbaa !717
  store i8* getelementptr inbounds ([4 x i8]* @.str87, i64 0, i64 0), i8** @sgr_end, align 8, !dbg !2025, !tbaa !717
  ret i8* null, !dbg !2026
}

; Function Attrs: nounwind
declare i32 @getopt_long(i32, i8**, i8*, %struct.option*, i32*) #2

; Function Attrs: nounwind readnone
declare void @llvm.dbg.value(metadata, i64, metadata) #1

; Function Attrs: nounwind readnone
declare { i64, i1 } @llvm.uadd.with.overflow.i64(i64, i64) #1

attributes #0 = { noreturn nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { noreturn nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind readonly "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #7 = { nounwind readnone "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #8 = { nounwind }
attributes #9 = { noreturn "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #10 = { cold nounwind }
attributes #11 = { noreturn nounwind }
attributes #12 = { nounwind readonly }
attributes #13 = { noreturn }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!709, !710}
!llvm.ident = !{!711}

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5 (http://llvm.org/git/clang.git 9ac60551645be7a3c5f9b702159052f2f1a5b26a) (http://llvm.org/git/llvm.git 5e7eecd8509707a77a6b84c7879b947e14698ef0)", i1 true, metadata !"", i32 0, metadata !2, metadata !45, metadata !46, metadata !605, metadata !45, metadata !""} ; [ DW_TAG_compile_unit ] [/home/kostas/workspace/test/grep-2.7/src/main.c] [DW_LANG_C99]
!1 = metadata !{metadata !"main.c", metadata !"/home/kostas/workspace/test/grep-2.7/src"}
!2 = metadata !{metadata !3, metadata !19, metadata !23, metadata !27, metadata !32, metadata !37}
!3 = metadata !{i32 786436, metadata !4, null, metadata !"", i32 27, i64 32, i64 32, i32 0, i32 0, null, metadata !5, i32 0, null, null, null} ; [ DW_TAG_enumeration_type ] [line 27, size 32, align 32, offset 0] [def] [from ]
!4 = metadata !{metadata !"/usr/include/x86_64-linux-gnu/bits/locale.h", metadata !"/home/kostas/workspace/test/grep-2.7/src"}
!5 = metadata !{metadata !6, metadata !7, metadata !8, metadata !9, metadata !10, metadata !11, metadata !12, metadata !13, metadata !14, metadata !15, metadata !16, metadata !17, metadata !18}
!6 = metadata !{i32 786472, metadata !"__LC_CTYPE", i64 0} ; [ DW_TAG_enumerator ] [__LC_CTYPE :: 0]
!7 = metadata !{i32 786472, metadata !"__LC_NUMERIC", i64 1} ; [ DW_TAG_enumerator ] [__LC_NUMERIC :: 1]
!8 = metadata !{i32 786472, metadata !"__LC_TIME", i64 2} ; [ DW_TAG_enumerator ] [__LC_TIME :: 2]
!9 = metadata !{i32 786472, metadata !"__LC_COLLATE", i64 3} ; [ DW_TAG_enumerator ] [__LC_COLLATE :: 3]
!10 = metadata !{i32 786472, metadata !"__LC_MONETARY", i64 4} ; [ DW_TAG_enumerator ] [__LC_MONETARY :: 4]
!11 = metadata !{i32 786472, metadata !"__LC_MESSAGES", i64 5} ; [ DW_TAG_enumerator ] [__LC_MESSAGES :: 5]
!12 = metadata !{i32 786472, metadata !"__LC_ALL", i64 6} ; [ DW_TAG_enumerator ] [__LC_ALL :: 6]
!13 = metadata !{i32 786472, metadata !"__LC_PAPER", i64 7} ; [ DW_TAG_enumerator ] [__LC_PAPER :: 7]
!14 = metadata !{i32 786472, metadata !"__LC_NAME", i64 8} ; [ DW_TAG_enumerator ] [__LC_NAME :: 8]
!15 = metadata !{i32 786472, metadata !"__LC_ADDRESS", i64 9} ; [ DW_TAG_enumerator ] [__LC_ADDRESS :: 9]
!16 = metadata !{i32 786472, metadata !"__LC_TELEPHONE", i64 10} ; [ DW_TAG_enumerator ] [__LC_TELEPHONE :: 10]
!17 = metadata !{i32 786472, metadata !"__LC_MEASUREMENT", i64 11} ; [ DW_TAG_enumerator ] [__LC_MEASUREMENT :: 11]
!18 = metadata !{i32 786472, metadata !"__LC_IDENTIFICATION", i64 12} ; [ DW_TAG_enumerator ] [__LC_IDENTIFICATION :: 12]
!19 = metadata !{i32 786436, metadata !20, null, metadata !"", i32 44, i64 32, i64 32, i32 0, i32 0, null, metadata !21, i32 0, null, null, null} ; [ DW_TAG_enumeration_type ] [line 44, size 32, align 32, offset 0] [def] [from ]
!20 = metadata !{metadata !"./system.h", metadata !"/home/kostas/workspace/test/grep-2.7/src"}
!21 = metadata !{metadata !22}
!22 = metadata !{i32 786472, metadata !"EXIT_TROUBLE", i64 2} ; [ DW_TAG_enumerator ] [EXIT_TROUBLE :: 2]
!23 = metadata !{i32 786436, metadata !1, null, metadata !"", i32 382, i64 32, i64 32, i32 0, i32 0, null, metadata !24, i32 0, null, null, null} ; [ DW_TAG_enumeration_type ] [line 382, size 32, align 32, offset 0] [def] [from ]
!24 = metadata !{metadata !25, metadata !26}
!25 = metadata !{i32 786472, metadata !"READ_DEVICES", i64 0} ; [ DW_TAG_enumerator ] [READ_DEVICES :: 0]
!26 = metadata !{i32 786472, metadata !"SKIP_DEVICES", i64 1} ; [ DW_TAG_enumerator ] [SKIP_DEVICES :: 1]
!27 = metadata !{i32 786436, metadata !1, null, metadata !"", i32 571, i64 32, i64 32, i32 0, i32 0, null, metadata !28, i32 0, null, null, null} ; [ DW_TAG_enumeration_type ] [line 571, size 32, align 32, offset 0] [def] [from ]
!28 = metadata !{metadata !29, metadata !30, metadata !31}
!29 = metadata !{i32 786472, metadata !"BINARY_BINARY_FILES", i64 0} ; [ DW_TAG_enumerator ] [BINARY_BINARY_FILES :: 0]
!30 = metadata !{i32 786472, metadata !"TEXT_BINARY_FILES", i64 1} ; [ DW_TAG_enumerator ] [TEXT_BINARY_FILES :: 1]
!31 = metadata !{i32 786472, metadata !"WITHOUT_MATCH_BINARY_FILES", i64 2} ; [ DW_TAG_enumerator ] [WITHOUT_MATCH_BINARY_FILES :: 2]
!32 = metadata !{i32 786436, metadata !1, null, metadata !"directories_type", i32 361, i64 32, i64 32, i32 0, i32 0, null, metadata !33, i32 0, null, null, null} ; [ DW_TAG_enumeration_type ] [directories_type] [line 361, size 32, align 32, offset 0] [def] [from ]
!33 = metadata !{metadata !34, metadata !35, metadata !36}
!34 = metadata !{i32 786472, metadata !"READ_DIRECTORIES", i64 2} ; [ DW_TAG_enumerator ] [READ_DIRECTORIES :: 2]
!35 = metadata !{i32 786472, metadata !"RECURSE_DIRECTORIES", i64 3} ; [ DW_TAG_enumerator ] [RECURSE_DIRECTORIES :: 3]
!36 = metadata !{i32 786472, metadata !"SKIP_DIRECTORIES", i64 4} ; [ DW_TAG_enumerator ] [SKIP_DIRECTORIES :: 4]
!37 = metadata !{i32 786436, metadata !38, null, metadata !"strtol_error", i32 26, i64 32, i64 32, i32 0, i32 0, null, metadata !39, i32 0, null, null, null} ; [ DW_TAG_enumeration_type ] [strtol_error] [line 26, size 32, align 32, offset 0] [def] [from ]
!38 = metadata !{metadata !"../lib/xstrtol.h", metadata !"/home/kostas/workspace/test/grep-2.7/src"}
!39 = metadata !{metadata !40, metadata !41, metadata !42, metadata !43, metadata !44}
!40 = metadata !{i32 786472, metadata !"LONGINT_OK", i64 0} ; [ DW_TAG_enumerator ] [LONGINT_OK :: 0]
!41 = metadata !{i32 786472, metadata !"LONGINT_OVERFLOW", i64 1} ; [ DW_TAG_enumerator ] [LONGINT_OVERFLOW :: 1]
!42 = metadata !{i32 786472, metadata !"LONGINT_INVALID_SUFFIX_CHAR", i64 2} ; [ DW_TAG_enumerator ] [LONGINT_INVALID_SUFFIX_CHAR :: 2]
!43 = metadata !{i32 786472, metadata !"LONGINT_INVALID_SUFFIX_CHAR_WITH_OVERFLOW", i64 3} ; [ DW_TAG_enumerator ] [LONGINT_INVALID_SUFFIX_CHAR_WITH_OVERFLOW :: 3]
!44 = metadata !{i32 786472, metadata !"LONGINT_INVALID", i64 4} ; [ DW_TAG_enumerator ] [LONGINT_INVALID :: 4]
!45 = metadata !{i32 0}
!46 = metadata !{metadata !47, metadata !54, metadata !205, metadata !269, metadata !277, metadata !282, metadata !285, metadata !301, metadata !308, metadata !315, metadata !321, metadata !331, metadata !336, metadata !346, metadata !360, metadata !369, metadata !381, metadata !395, metadata !417, metadata !432, metadata !458, metadata !463, metadata !481, metadata !487, metadata !496, metadata !497, metadata !526, metadata !527, metadata !528, metadata !529, metadata !532, metadata !540, metadata !557, metadata !574, metadata !589}
!47 = metadata !{i32 786478, metadata !1, metadata !48, metadata !"usage", metadata !"usage", metadata !"", i32 1375, metadata !49, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, void (i32)* @usage, null, null, metadata !52, i32 1376} ; [ DW_TAG_subprogram ] [line 1375] [def] [scope 1376] [usage]
!48 = metadata !{i32 786473, metadata !1}         ; [ DW_TAG_file_type ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!49 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !50, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!50 = metadata !{null, metadata !51}
!51 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!52 = metadata !{metadata !53}
!53 = metadata !{i32 786689, metadata !47, metadata !"status", metadata !48, i32 16778591, metadata !51, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [status] [line 1375]
!54 = metadata !{i32 786478, metadata !1, metadata !48, metadata !"main", metadata !"main", metadata !"", i32 1754, metadata !55, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i32, i8**)* @main, null, null, metadata !60, i32 1755} ; [ DW_TAG_subprogram ] [line 1754] [def] [scope 1755] [main]
!55 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !56, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!56 = metadata !{metadata !51, metadata !51, metadata !57}
!57 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !58} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!58 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !59} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from char]
!59 = metadata !{i32 786468, null, null, metadata !"char", i32 0, i64 8, i64 8, i64 0, i32 0, i32 6} ; [ DW_TAG_base_type ] [char] [line 0, size 8, align 8, offset 0, enc DW_ATE_signed_char]
!60 = metadata !{metadata !61, metadata !62, metadata !63, metadata !64, metadata !68, metadata !69, metadata !70, metadata !71, metadata !72, metadata !73, metadata !74, metadata !75, metadata !131, metadata !135, metadata !136, metadata !141, metadata !142, metadata !145, metadata !146, metadata !148, metadata !149, metadata !151, metadata !152, metadata !154, metadata !155, metadata !159, metadata !162, metadata !163, metadata !165, metadata !166, metadata !169, metadata !170, metadata !172, metadata !173, metadata !176, metadata !177, metadata !179, metadata !180, metadata !185, metadata !188, metadata !189, metadata !191, metadata !192, metadata !195, metadata !199, metadata !201, metadata !202, metadata !204}
!61 = metadata !{i32 786689, metadata !54, metadata !"argc", metadata !48, i32 16778970, metadata !51, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [argc] [line 1754]
!62 = metadata !{i32 786689, metadata !54, metadata !"argv", metadata !48, i32 33556186, metadata !57, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [argv] [line 1754]
!63 = metadata !{i32 786688, metadata !54, metadata !"keys", metadata !48, i32 1756, metadata !58, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [keys] [line 1756]
!64 = metadata !{i32 786688, metadata !54, metadata !"keycc", metadata !48, i32 1757, metadata !65, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [keycc] [line 1757]
!65 = metadata !{i32 786454, metadata !66, null, metadata !"size_t", i32 42, i64 0, i64 0, i64 0, i32 0, metadata !67} ; [ DW_TAG_typedef ] [size_t] [line 42, size 0, align 0, offset 0] [from long unsigned int]
!66 = metadata !{metadata !"/usr/local/bin/../lib/clang/3.5/include/stddef.h", metadata !"/home/kostas/workspace/test/grep-2.7/src"}
!67 = metadata !{i32 786468, null, null, metadata !"long unsigned int", i32 0, i64 64, i64 64, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [long unsigned int] [line 0, size 64, align 64, offset 0, enc DW_ATE_unsigned]
!68 = metadata !{i32 786688, metadata !54, metadata !"oldcc", metadata !48, i32 1757, metadata !65, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [oldcc] [line 1757]
!69 = metadata !{i32 786688, metadata !54, metadata !"keyalloc", metadata !48, i32 1757, metadata !65, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [keyalloc] [line 1757]
!70 = metadata !{i32 786688, metadata !54, metadata !"with_filenames", metadata !48, i32 1758, metadata !51, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [with_filenames] [line 1758]
!71 = metadata !{i32 786688, metadata !54, metadata !"opt", metadata !48, i32 1759, metadata !51, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [opt] [line 1759]
!72 = metadata !{i32 786688, metadata !54, metadata !"cc", metadata !48, i32 1759, metadata !51, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [cc] [line 1759]
!73 = metadata !{i32 786688, metadata !54, metadata !"status", metadata !48, i32 1759, metadata !51, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [status] [line 1759]
!74 = metadata !{i32 786688, metadata !54, metadata !"default_context", metadata !48, i32 1760, metadata !51, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [default_context] [line 1760]
!75 = metadata !{i32 786688, metadata !54, metadata !"fp", metadata !48, i32 1761, metadata !76, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [fp] [line 1761]
!76 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !77} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from FILE]
!77 = metadata !{i32 786454, metadata !78, null, metadata !"FILE", i32 49, i64 0, i64 0, i64 0, i32 0, metadata !79} ; [ DW_TAG_typedef ] [FILE] [line 49, size 0, align 0, offset 0] [from _IO_FILE]
!78 = metadata !{metadata !"/usr/include/stdio.h", metadata !"/home/kostas/workspace/test/grep-2.7/src"}
!79 = metadata !{i32 786451, metadata !80, null, metadata !"_IO_FILE", i32 273, i64 1728, i64 64, i32 0, i32 0, null, metadata !81, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [_IO_FILE] [line 273, size 1728, align 64, offset 0] [def] [from ]
!80 = metadata !{metadata !"/usr/include/libio.h", metadata !"/home/kostas/workspace/test/grep-2.7/src"}
!81 = metadata !{metadata !82, metadata !83, metadata !84, metadata !85, metadata !86, metadata !87, metadata !88, metadata !89, metadata !90, metadata !91, metadata !92, metadata !93, metadata !94, metadata !102, metadata !103, metadata !104, metadata !105, metadata !109, metadata !111, metadata !113, metadata !117, metadata !119, metadata !121, metadata !122, metadata !123, metadata !124, metadata !125, metadata !126, metadata !127}
!82 = metadata !{i32 786445, metadata !80, metadata !79, metadata !"_flags", i32 274, i64 32, i64 32, i64 0, i32 0, metadata !51} ; [ DW_TAG_member ] [_flags] [line 274, size 32, align 32, offset 0] [from int]
!83 = metadata !{i32 786445, metadata !80, metadata !79, metadata !"_IO_read_ptr", i32 279, i64 64, i64 64, i64 64, i32 0, metadata !58} ; [ DW_TAG_member ] [_IO_read_ptr] [line 279, size 64, align 64, offset 64] [from ]
!84 = metadata !{i32 786445, metadata !80, metadata !79, metadata !"_IO_read_end", i32 280, i64 64, i64 64, i64 128, i32 0, metadata !58} ; [ DW_TAG_member ] [_IO_read_end] [line 280, size 64, align 64, offset 128] [from ]
!85 = metadata !{i32 786445, metadata !80, metadata !79, metadata !"_IO_read_base", i32 281, i64 64, i64 64, i64 192, i32 0, metadata !58} ; [ DW_TAG_member ] [_IO_read_base] [line 281, size 64, align 64, offset 192] [from ]
!86 = metadata !{i32 786445, metadata !80, metadata !79, metadata !"_IO_write_base", i32 282, i64 64, i64 64, i64 256, i32 0, metadata !58} ; [ DW_TAG_member ] [_IO_write_base] [line 282, size 64, align 64, offset 256] [from ]
!87 = metadata !{i32 786445, metadata !80, metadata !79, metadata !"_IO_write_ptr", i32 283, i64 64, i64 64, i64 320, i32 0, metadata !58} ; [ DW_TAG_member ] [_IO_write_ptr] [line 283, size 64, align 64, offset 320] [from ]
!88 = metadata !{i32 786445, metadata !80, metadata !79, metadata !"_IO_write_end", i32 284, i64 64, i64 64, i64 384, i32 0, metadata !58} ; [ DW_TAG_member ] [_IO_write_end] [line 284, size 64, align 64, offset 384] [from ]
!89 = metadata !{i32 786445, metadata !80, metadata !79, metadata !"_IO_buf_base", i32 285, i64 64, i64 64, i64 448, i32 0, metadata !58} ; [ DW_TAG_member ] [_IO_buf_base] [line 285, size 64, align 64, offset 448] [from ]
!90 = metadata !{i32 786445, metadata !80, metadata !79, metadata !"_IO_buf_end", i32 286, i64 64, i64 64, i64 512, i32 0, metadata !58} ; [ DW_TAG_member ] [_IO_buf_end] [line 286, size 64, align 64, offset 512] [from ]
!91 = metadata !{i32 786445, metadata !80, metadata !79, metadata !"_IO_save_base", i32 288, i64 64, i64 64, i64 576, i32 0, metadata !58} ; [ DW_TAG_member ] [_IO_save_base] [line 288, size 64, align 64, offset 576] [from ]
!92 = metadata !{i32 786445, metadata !80, metadata !79, metadata !"_IO_backup_base", i32 289, i64 64, i64 64, i64 640, i32 0, metadata !58} ; [ DW_TAG_member ] [_IO_backup_base] [line 289, size 64, align 64, offset 640] [from ]
!93 = metadata !{i32 786445, metadata !80, metadata !79, metadata !"_IO_save_end", i32 290, i64 64, i64 64, i64 704, i32 0, metadata !58} ; [ DW_TAG_member ] [_IO_save_end] [line 290, size 64, align 64, offset 704] [from ]
!94 = metadata !{i32 786445, metadata !80, metadata !79, metadata !"_markers", i32 292, i64 64, i64 64, i64 768, i32 0, metadata !95} ; [ DW_TAG_member ] [_markers] [line 292, size 64, align 64, offset 768] [from ]
!95 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !96} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from _IO_marker]
!96 = metadata !{i32 786451, metadata !80, null, metadata !"_IO_marker", i32 188, i64 192, i64 64, i32 0, i32 0, null, metadata !97, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [_IO_marker] [line 188, size 192, align 64, offset 0] [def] [from ]
!97 = metadata !{metadata !98, metadata !99, metadata !101}
!98 = metadata !{i32 786445, metadata !80, metadata !96, metadata !"_next", i32 189, i64 64, i64 64, i64 0, i32 0, metadata !95} ; [ DW_TAG_member ] [_next] [line 189, size 64, align 64, offset 0] [from ]
!99 = metadata !{i32 786445, metadata !80, metadata !96, metadata !"_sbuf", i32 190, i64 64, i64 64, i64 64, i32 0, metadata !100} ; [ DW_TAG_member ] [_sbuf] [line 190, size 64, align 64, offset 64] [from ]
!100 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !79} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from _IO_FILE]
!101 = metadata !{i32 786445, metadata !80, metadata !96, metadata !"_pos", i32 194, i64 32, i64 32, i64 128, i32 0, metadata !51} ; [ DW_TAG_member ] [_pos] [line 194, size 32, align 32, offset 128] [from int]
!102 = metadata !{i32 786445, metadata !80, metadata !79, metadata !"_chain", i32 294, i64 64, i64 64, i64 832, i32 0, metadata !100} ; [ DW_TAG_member ] [_chain] [line 294, size 64, align 64, offset 832] [from ]
!103 = metadata !{i32 786445, metadata !80, metadata !79, metadata !"_fileno", i32 296, i64 32, i64 32, i64 896, i32 0, metadata !51} ; [ DW_TAG_member ] [_fileno] [line 296, size 32, align 32, offset 896] [from int]
!104 = metadata !{i32 786445, metadata !80, metadata !79, metadata !"_flags2", i32 300, i64 32, i64 32, i64 928, i32 0, metadata !51} ; [ DW_TAG_member ] [_flags2] [line 300, size 32, align 32, offset 928] [from int]
!105 = metadata !{i32 786445, metadata !80, metadata !79, metadata !"_old_offset", i32 302, i64 64, i64 64, i64 960, i32 0, metadata !106} ; [ DW_TAG_member ] [_old_offset] [line 302, size 64, align 64, offset 960] [from __off_t]
!106 = metadata !{i32 786454, metadata !107, null, metadata !"__off_t", i32 141, i64 0, i64 0, i64 0, i32 0, metadata !108} ; [ DW_TAG_typedef ] [__off_t] [line 141, size 0, align 0, offset 0] [from long int]
!107 = metadata !{metadata !"/usr/include/x86_64-linux-gnu/bits/types.h", metadata !"/home/kostas/workspace/test/grep-2.7/src"}
!108 = metadata !{i32 786468, null, null, metadata !"long int", i32 0, i64 64, i64 64, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [long int] [line 0, size 64, align 64, offset 0, enc DW_ATE_signed]
!109 = metadata !{i32 786445, metadata !80, metadata !79, metadata !"_cur_column", i32 306, i64 16, i64 16, i64 1024, i32 0, metadata !110} ; [ DW_TAG_member ] [_cur_column] [line 306, size 16, align 16, offset 1024] [from unsigned short]
!110 = metadata !{i32 786468, null, null, metadata !"unsigned short", i32 0, i64 16, i64 16, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [unsigned short] [line 0, size 16, align 16, offset 0, enc DW_ATE_unsigned]
!111 = metadata !{i32 786445, metadata !80, metadata !79, metadata !"_vtable_offset", i32 307, i64 8, i64 8, i64 1040, i32 0, metadata !112} ; [ DW_TAG_member ] [_vtable_offset] [line 307, size 8, align 8, offset 1040] [from signed char]
!112 = metadata !{i32 786468, null, null, metadata !"signed char", i32 0, i64 8, i64 8, i64 0, i32 0, i32 6} ; [ DW_TAG_base_type ] [signed char] [line 0, size 8, align 8, offset 0, enc DW_ATE_signed_char]
!113 = metadata !{i32 786445, metadata !80, metadata !79, metadata !"_shortbuf", i32 308, i64 8, i64 8, i64 1048, i32 0, metadata !114} ; [ DW_TAG_member ] [_shortbuf] [line 308, size 8, align 8, offset 1048] [from ]
!114 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 8, i64 8, i32 0, i32 0, metadata !59, metadata !115, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 8, align 8, offset 0] [from char]
!115 = metadata !{metadata !116}
!116 = metadata !{i32 786465, i64 0, i64 1}       ; [ DW_TAG_subrange_type ] [0, 0]
!117 = metadata !{i32 786445, metadata !80, metadata !79, metadata !"_lock", i32 312, i64 64, i64 64, i64 1088, i32 0, metadata !118} ; [ DW_TAG_member ] [_lock] [line 312, size 64, align 64, offset 1088] [from ]
!118 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, null} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!119 = metadata !{i32 786445, metadata !80, metadata !79, metadata !"_offset", i32 321, i64 64, i64 64, i64 1152, i32 0, metadata !120} ; [ DW_TAG_member ] [_offset] [line 321, size 64, align 64, offset 1152] [from __off64_t]
!120 = metadata !{i32 786454, metadata !107, null, metadata !"__off64_t", i32 142, i64 0, i64 0, i64 0, i32 0, metadata !108} ; [ DW_TAG_typedef ] [__off64_t] [line 142, size 0, align 0, offset 0] [from long int]
!121 = metadata !{i32 786445, metadata !80, metadata !79, metadata !"__pad1", i32 330, i64 64, i64 64, i64 1216, i32 0, metadata !118} ; [ DW_TAG_member ] [__pad1] [line 330, size 64, align 64, offset 1216] [from ]
!122 = metadata !{i32 786445, metadata !80, metadata !79, metadata !"__pad2", i32 331, i64 64, i64 64, i64 1280, i32 0, metadata !118} ; [ DW_TAG_member ] [__pad2] [line 331, size 64, align 64, offset 1280] [from ]
!123 = metadata !{i32 786445, metadata !80, metadata !79, metadata !"__pad3", i32 332, i64 64, i64 64, i64 1344, i32 0, metadata !118} ; [ DW_TAG_member ] [__pad3] [line 332, size 64, align 64, offset 1344] [from ]
!124 = metadata !{i32 786445, metadata !80, metadata !79, metadata !"__pad4", i32 333, i64 64, i64 64, i64 1408, i32 0, metadata !118} ; [ DW_TAG_member ] [__pad4] [line 333, size 64, align 64, offset 1408] [from ]
!125 = metadata !{i32 786445, metadata !80, metadata !79, metadata !"__pad5", i32 334, i64 64, i64 64, i64 1472, i32 0, metadata !65} ; [ DW_TAG_member ] [__pad5] [line 334, size 64, align 64, offset 1472] [from size_t]
!126 = metadata !{i32 786445, metadata !80, metadata !79, metadata !"_mode", i32 336, i64 32, i64 32, i64 1536, i32 0, metadata !51} ; [ DW_TAG_member ] [_mode] [line 336, size 32, align 32, offset 1536] [from int]
!127 = metadata !{i32 786445, metadata !80, metadata !79, metadata !"_unused2", i32 338, i64 160, i64 8, i64 1568, i32 0, metadata !128} ; [ DW_TAG_member ] [_unused2] [line 338, size 160, align 8, offset 1568] [from ]
!128 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 160, i64 8, i32 0, i32 0, metadata !59, metadata !129, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 160, align 8, offset 0] [from char]
!129 = metadata !{metadata !130}
!130 = metadata !{i32 786465, i64 0, i64 20}      ; [ DW_TAG_subrange_type ] [0, 19]
!131 = metadata !{i32 786688, metadata !132, metadata !"__s1_len", metadata !48, i32 1815, metadata !65, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__s1_len] [line 1815]
!132 = metadata !{i32 786443, metadata !1, metadata !133, i32 1815, i32 0, i32 6} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!133 = metadata !{i32 786443, metadata !1, metadata !134, i32 1815, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!134 = metadata !{i32 786443, metadata !1, metadata !54, i32 1799, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!135 = metadata !{i32 786688, metadata !132, metadata !"__s2_len", metadata !48, i32 1815, metadata !65, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__s2_len] [line 1815]
!136 = metadata !{i32 786688, metadata !137, metadata !"__s1", metadata !48, i32 1815, metadata !138, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__s1] [line 1815]
!137 = metadata !{i32 786443, metadata !1, metadata !132, i32 1815, i32 0, i32 7} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!138 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !139} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!139 = metadata !{i32 786470, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, metadata !140} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from unsigned char]
!140 = metadata !{i32 786468, null, null, metadata !"unsigned char", i32 0, i64 8, i64 8, i64 0, i32 0, i32 8} ; [ DW_TAG_base_type ] [unsigned char] [line 0, size 8, align 8, offset 0, enc DW_ATE_unsigned_char]
!141 = metadata !{i32 786688, metadata !137, metadata !"__result", metadata !48, i32 1815, metadata !51, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__result] [line 1815]
!142 = metadata !{i32 786688, metadata !143, metadata !"__s1_len", metadata !48, i32 1817, metadata !65, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__s1_len] [line 1817]
!143 = metadata !{i32 786443, metadata !1, metadata !144, i32 1817, i32 0, i32 14} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!144 = metadata !{i32 786443, metadata !1, metadata !133, i32 1817, i32 0, i32 13} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!145 = metadata !{i32 786688, metadata !143, metadata !"__s2_len", metadata !48, i32 1817, metadata !65, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__s2_len] [line 1817]
!146 = metadata !{i32 786688, metadata !147, metadata !"__s1", metadata !48, i32 1817, metadata !138, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__s1] [line 1817]
!147 = metadata !{i32 786443, metadata !1, metadata !143, i32 1817, i32 0, i32 15} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!148 = metadata !{i32 786688, metadata !147, metadata !"__result", metadata !48, i32 1817, metadata !51, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__result] [line 1817]
!149 = metadata !{i32 786688, metadata !150, metadata !"__s1_len", metadata !48, i32 1898, metadata !65, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__s1_len] [line 1898]
!150 = metadata !{i32 786443, metadata !1, metadata !134, i32 1898, i32 0, i32 21} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!151 = metadata !{i32 786688, metadata !150, metadata !"__s2_len", metadata !48, i32 1898, metadata !65, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__s2_len] [line 1898]
!152 = metadata !{i32 786688, metadata !153, metadata !"__s1", metadata !48, i32 1898, metadata !138, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__s1] [line 1898]
!153 = metadata !{i32 786443, metadata !1, metadata !150, i32 1898, i32 0, i32 22} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!154 = metadata !{i32 786688, metadata !153, metadata !"__result", metadata !48, i32 1898, metadata !51, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__result] [line 1898]
!155 = metadata !{i32 786688, metadata !156, metadata !"value", metadata !48, i32 1941, metadata !157, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [value] [line 1941]
!156 = metadata !{i32 786443, metadata !1, metadata !134, i32 1940, i32 0, i32 34} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!157 = metadata !{i32 786454, metadata !158, null, metadata !"uintmax_t", i32 136, i64 0, i64 0, i64 0, i32 0, metadata !67} ; [ DW_TAG_typedef ] [uintmax_t] [line 136, size 0, align 0, offset 0] [from long unsigned int]
!158 = metadata !{metadata !"/usr/include/stdint.h", metadata !"/home/kostas/workspace/test/grep-2.7/src"}
!159 = metadata !{i32 786688, metadata !160, metadata !"__s1_len", metadata !48, i32 2002, metadata !65, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__s1_len] [line 2002]
!160 = metadata !{i32 786443, metadata !1, metadata !161, i32 2002, i32 0, i32 38} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!161 = metadata !{i32 786443, metadata !1, metadata !134, i32 2002, i32 0, i32 37} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!162 = metadata !{i32 786688, metadata !160, metadata !"__s2_len", metadata !48, i32 2002, metadata !65, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__s2_len] [line 2002]
!163 = metadata !{i32 786688, metadata !164, metadata !"__s1", metadata !48, i32 2002, metadata !138, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__s1] [line 2002]
!164 = metadata !{i32 786443, metadata !1, metadata !160, i32 2002, i32 0, i32 39} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!165 = metadata !{i32 786688, metadata !164, metadata !"__result", metadata !48, i32 2002, metadata !51, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__result] [line 2002]
!166 = metadata !{i32 786688, metadata !167, metadata !"__s1_len", metadata !48, i32 2004, metadata !65, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__s1_len] [line 2004]
!167 = metadata !{i32 786443, metadata !1, metadata !168, i32 2004, i32 0, i32 46} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!168 = metadata !{i32 786443, metadata !1, metadata !161, i32 2004, i32 0, i32 45} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!169 = metadata !{i32 786688, metadata !167, metadata !"__s2_len", metadata !48, i32 2004, metadata !65, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__s2_len] [line 2004]
!170 = metadata !{i32 786688, metadata !171, metadata !"__s1", metadata !48, i32 2004, metadata !138, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__s1] [line 2004]
!171 = metadata !{i32 786443, metadata !1, metadata !167, i32 2004, i32 0, i32 47} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!172 = metadata !{i32 786688, metadata !171, metadata !"__result", metadata !48, i32 2004, metadata !51, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__result] [line 2004]
!173 = metadata !{i32 786688, metadata !174, metadata !"__s1_len", metadata !48, i32 2006, metadata !65, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__s1_len] [line 2006]
!174 = metadata !{i32 786443, metadata !1, metadata !175, i32 2006, i32 0, i32 54} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!175 = metadata !{i32 786443, metadata !1, metadata !168, i32 2006, i32 0, i32 53} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!176 = metadata !{i32 786688, metadata !174, metadata !"__s2_len", metadata !48, i32 2006, metadata !65, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__s2_len] [line 2006]
!177 = metadata !{i32 786688, metadata !178, metadata !"__s1", metadata !48, i32 2006, metadata !138, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__s1] [line 2006]
!178 = metadata !{i32 786443, metadata !1, metadata !174, i32 2006, i32 0, i32 55} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!179 = metadata !{i32 786688, metadata !178, metadata !"__result", metadata !48, i32 2006, metadata !51, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__result] [line 2006]
!180 = metadata !{i32 786688, metadata !181, metadata !"t", metadata !48, i32 2029, metadata !183, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [t] [line 2029]
!181 = metadata !{i32 786443, metadata !1, metadata !182, i32 2028, i32 0, i32 67} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!182 = metadata !{i32 786443, metadata !1, metadata !134, i32 2027, i32 0, i32 66} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!183 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !184} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!184 = metadata !{i32 786470, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, metadata !59} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from char]
!185 = metadata !{i32 786688, metadata !186, metadata !"__s1_len", metadata !48, i32 2031, metadata !65, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__s1_len] [line 2031]
!186 = metadata !{i32 786443, metadata !1, metadata !187, i32 2031, i32 0, i32 69} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!187 = metadata !{i32 786443, metadata !1, metadata !181, i32 2030, i32 0, i32 68} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!188 = metadata !{i32 786688, metadata !186, metadata !"__s2_len", metadata !48, i32 2031, metadata !65, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__s2_len] [line 2031]
!189 = metadata !{i32 786688, metadata !190, metadata !"__s1", metadata !48, i32 2031, metadata !138, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__s1] [line 2031]
!190 = metadata !{i32 786443, metadata !1, metadata !186, i32 2031, i32 0, i32 70} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!191 = metadata !{i32 786688, metadata !190, metadata !"__result", metadata !48, i32 2031, metadata !51, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__result] [line 2031]
!192 = metadata !{i32 786688, metadata !193, metadata !"userval", metadata !48, i32 2108, metadata !58, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [userval] [line 2108]
!193 = metadata !{i32 786443, metadata !1, metadata !194, i32 2106, i32 0, i32 88} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!194 = metadata !{i32 786443, metadata !1, metadata !54, i32 2105, i32 0, i32 87} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!195 = metadata !{i32 786688, metadata !196, metadata !"file", metadata !48, i32 2171, metadata !58, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [file] [line 2171]
!196 = metadata !{i32 786443, metadata !1, metadata !197, i32 2170, i32 0, i32 104} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!197 = metadata !{i32 786443, metadata !1, metadata !198, i32 2167, i32 0, i32 103} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!198 = metadata !{i32 786443, metadata !1, metadata !54, i32 2166, i32 0, i32 102} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!199 = metadata !{i32 786688, metadata !200, metadata !"__s1_len", metadata !48, i32 2182, metadata !65, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__s1_len] [line 2182]
!200 = metadata !{i32 786443, metadata !1, metadata !196, i32 2182, i32 0, i32 109} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!201 = metadata !{i32 786688, metadata !200, metadata !"__s2_len", metadata !48, i32 2182, metadata !65, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__s2_len] [line 2182]
!202 = metadata !{i32 786688, metadata !203, metadata !"__s1", metadata !48, i32 2182, metadata !138, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__s1] [line 2182]
!203 = metadata !{i32 786443, metadata !1, metadata !200, i32 2182, i32 0, i32 110} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!204 = metadata !{i32 786688, metadata !203, metadata !"__result", metadata !48, i32 2182, metadata !51, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__result] [line 2182]
!205 = metadata !{i32 786478, metadata !1, metadata !48, metadata !"grepfile", metadata !"grepfile", metadata !"", i32 1190, metadata !206, i1 true, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i8*, %struct.stats*)* @grepfile, null, null, metadata !251, i32 1191} ; [ DW_TAG_subprogram ] [line 1190] [local] [def] [scope 1191] [grepfile]
!206 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !207, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!207 = metadata !{metadata !51, metadata !183, metadata !208}
!208 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !209} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from stats]
!209 = metadata !{i32 786451, metadata !1, null, metadata !"stats", i32 62, i64 1216, i64 64, i32 0, i32 0, null, metadata !210, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [stats] [line 62, size 1216, align 64, offset 0] [def] [from ]
!210 = metadata !{metadata !211, metadata !214}
!211 = metadata !{i32 786445, metadata !1, metadata !209, metadata !"parent", i32 64, i64 64, i64 64, i64 0, i32 0, metadata !212} ; [ DW_TAG_member ] [parent] [line 64, size 64, align 64, offset 0] [from ]
!212 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !213} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!213 = metadata !{i32 786470, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, metadata !209} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from stats]
!214 = metadata !{i32 786445, metadata !1, metadata !209, metadata !"stat", i32 65, i64 1152, i64 64, i64 64, i32 0, metadata !215} ; [ DW_TAG_member ] [stat] [line 65, size 1152, align 64, offset 64] [from stat]
!215 = metadata !{i32 786451, metadata !216, null, metadata !"stat", i32 46, i64 1152, i64 64, i32 0, i32 0, null, metadata !217, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [stat] [line 46, size 1152, align 64, offset 0] [def] [from ]
!216 = metadata !{metadata !"/usr/include/x86_64-linux-gnu/bits/stat.h", metadata !"/home/kostas/workspace/test/grep-2.7/src"}
!217 = metadata !{metadata !218, metadata !220, metadata !222, metadata !224, metadata !227, metadata !229, metadata !231, metadata !232, metadata !233, metadata !234, metadata !236, metadata !238, metadata !245, metadata !246, metadata !247}
!218 = metadata !{i32 786445, metadata !216, metadata !215, metadata !"st_dev", i32 48, i64 64, i64 64, i64 0, i32 0, metadata !219} ; [ DW_TAG_member ] [st_dev] [line 48, size 64, align 64, offset 0] [from __dev_t]
!219 = metadata !{i32 786454, metadata !107, null, metadata !"__dev_t", i32 134, i64 0, i64 0, i64 0, i32 0, metadata !67} ; [ DW_TAG_typedef ] [__dev_t] [line 134, size 0, align 0, offset 0] [from long unsigned int]
!220 = metadata !{i32 786445, metadata !216, metadata !215, metadata !"st_ino", i32 53, i64 64, i64 64, i64 64, i32 0, metadata !221} ; [ DW_TAG_member ] [st_ino] [line 53, size 64, align 64, offset 64] [from __ino_t]
!221 = metadata !{i32 786454, metadata !107, null, metadata !"__ino_t", i32 137, i64 0, i64 0, i64 0, i32 0, metadata !67} ; [ DW_TAG_typedef ] [__ino_t] [line 137, size 0, align 0, offset 0] [from long unsigned int]
!222 = metadata !{i32 786445, metadata !216, metadata !215, metadata !"st_nlink", i32 61, i64 64, i64 64, i64 128, i32 0, metadata !223} ; [ DW_TAG_member ] [st_nlink] [line 61, size 64, align 64, offset 128] [from __nlink_t]
!223 = metadata !{i32 786454, metadata !107, null, metadata !"__nlink_t", i32 140, i64 0, i64 0, i64 0, i32 0, metadata !67} ; [ DW_TAG_typedef ] [__nlink_t] [line 140, size 0, align 0, offset 0] [from long unsigned int]
!224 = metadata !{i32 786445, metadata !216, metadata !215, metadata !"st_mode", i32 62, i64 32, i64 32, i64 192, i32 0, metadata !225} ; [ DW_TAG_member ] [st_mode] [line 62, size 32, align 32, offset 192] [from __mode_t]
!225 = metadata !{i32 786454, metadata !107, null, metadata !"__mode_t", i32 139, i64 0, i64 0, i64 0, i32 0, metadata !226} ; [ DW_TAG_typedef ] [__mode_t] [line 139, size 0, align 0, offset 0] [from unsigned int]
!226 = metadata !{i32 786468, null, null, metadata !"unsigned int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [unsigned int] [line 0, size 32, align 32, offset 0, enc DW_ATE_unsigned]
!227 = metadata !{i32 786445, metadata !216, metadata !215, metadata !"st_uid", i32 64, i64 32, i64 32, i64 224, i32 0, metadata !228} ; [ DW_TAG_member ] [st_uid] [line 64, size 32, align 32, offset 224] [from __uid_t]
!228 = metadata !{i32 786454, metadata !107, null, metadata !"__uid_t", i32 135, i64 0, i64 0, i64 0, i32 0, metadata !226} ; [ DW_TAG_typedef ] [__uid_t] [line 135, size 0, align 0, offset 0] [from unsigned int]
!229 = metadata !{i32 786445, metadata !216, metadata !215, metadata !"st_gid", i32 65, i64 32, i64 32, i64 256, i32 0, metadata !230} ; [ DW_TAG_member ] [st_gid] [line 65, size 32, align 32, offset 256] [from __gid_t]
!230 = metadata !{i32 786454, metadata !107, null, metadata !"__gid_t", i32 136, i64 0, i64 0, i64 0, i32 0, metadata !226} ; [ DW_TAG_typedef ] [__gid_t] [line 136, size 0, align 0, offset 0] [from unsigned int]
!231 = metadata !{i32 786445, metadata !216, metadata !215, metadata !"__pad0", i32 67, i64 32, i64 32, i64 288, i32 0, metadata !51} ; [ DW_TAG_member ] [__pad0] [line 67, size 32, align 32, offset 288] [from int]
!232 = metadata !{i32 786445, metadata !216, metadata !215, metadata !"st_rdev", i32 69, i64 64, i64 64, i64 320, i32 0, metadata !219} ; [ DW_TAG_member ] [st_rdev] [line 69, size 64, align 64, offset 320] [from __dev_t]
!233 = metadata !{i32 786445, metadata !216, metadata !215, metadata !"st_size", i32 74, i64 64, i64 64, i64 384, i32 0, metadata !106} ; [ DW_TAG_member ] [st_size] [line 74, size 64, align 64, offset 384] [from __off_t]
!234 = metadata !{i32 786445, metadata !216, metadata !215, metadata !"st_blksize", i32 78, i64 64, i64 64, i64 448, i32 0, metadata !235} ; [ DW_TAG_member ] [st_blksize] [line 78, size 64, align 64, offset 448] [from __blksize_t]
!235 = metadata !{i32 786454, metadata !107, null, metadata !"__blksize_t", i32 164, i64 0, i64 0, i64 0, i32 0, metadata !108} ; [ DW_TAG_typedef ] [__blksize_t] [line 164, size 0, align 0, offset 0] [from long int]
!236 = metadata !{i32 786445, metadata !216, metadata !215, metadata !"st_blocks", i32 80, i64 64, i64 64, i64 512, i32 0, metadata !237} ; [ DW_TAG_member ] [st_blocks] [line 80, size 64, align 64, offset 512] [from __blkcnt_t]
!237 = metadata !{i32 786454, metadata !107, null, metadata !"__blkcnt_t", i32 169, i64 0, i64 0, i64 0, i32 0, metadata !108} ; [ DW_TAG_typedef ] [__blkcnt_t] [line 169, size 0, align 0, offset 0] [from long int]
!238 = metadata !{i32 786445, metadata !216, metadata !215, metadata !"st_atim", i32 91, i64 128, i64 64, i64 576, i32 0, metadata !239} ; [ DW_TAG_member ] [st_atim] [line 91, size 128, align 64, offset 576] [from timespec]
!239 = metadata !{i32 786451, metadata !240, null, metadata !"timespec", i32 120, i64 128, i64 64, i32 0, i32 0, null, metadata !241, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [timespec] [line 120, size 128, align 64, offset 0] [def] [from ]
!240 = metadata !{metadata !"/usr/include/time.h", metadata !"/home/kostas/workspace/test/grep-2.7/src"}
!241 = metadata !{metadata !242, metadata !244}
!242 = metadata !{i32 786445, metadata !240, metadata !239, metadata !"tv_sec", i32 122, i64 64, i64 64, i64 0, i32 0, metadata !243} ; [ DW_TAG_member ] [tv_sec] [line 122, size 64, align 64, offset 0] [from __time_t]
!243 = metadata !{i32 786454, metadata !107, null, metadata !"__time_t", i32 149, i64 0, i64 0, i64 0, i32 0, metadata !108} ; [ DW_TAG_typedef ] [__time_t] [line 149, size 0, align 0, offset 0] [from long int]
!244 = metadata !{i32 786445, metadata !240, metadata !239, metadata !"tv_nsec", i32 123, i64 64, i64 64, i64 64, i32 0, metadata !108} ; [ DW_TAG_member ] [tv_nsec] [line 123, size 64, align 64, offset 64] [from long int]
!245 = metadata !{i32 786445, metadata !216, metadata !215, metadata !"st_mtim", i32 92, i64 128, i64 64, i64 704, i32 0, metadata !239} ; [ DW_TAG_member ] [st_mtim] [line 92, size 128, align 64, offset 704] [from timespec]
!246 = metadata !{i32 786445, metadata !216, metadata !215, metadata !"st_ctim", i32 93, i64 128, i64 64, i64 832, i32 0, metadata !239} ; [ DW_TAG_member ] [st_ctim] [line 93, size 128, align 64, offset 832] [from timespec]
!247 = metadata !{i32 786445, metadata !216, metadata !215, metadata !"__unused", i32 106, i64 192, i64 64, i64 960, i32 0, metadata !248} ; [ DW_TAG_member ] [__unused] [line 106, size 192, align 64, offset 960] [from ]
!248 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 192, i64 64, i32 0, i32 0, metadata !108, metadata !249, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 192, align 64, offset 0] [from long int]
!249 = metadata !{metadata !250}
!250 = metadata !{i32 786465, i64 0, i64 3}       ; [ DW_TAG_subrange_type ] [0, 2]
!251 = metadata !{metadata !252, metadata !253, metadata !254, metadata !255, metadata !256, metadata !257, metadata !262}
!252 = metadata !{i32 786689, metadata !205, metadata !"file", metadata !48, i32 16778406, metadata !183, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [file] [line 1190]
!253 = metadata !{i32 786689, metadata !205, metadata !"stats", metadata !48, i32 33555622, metadata !208, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [stats] [line 1190]
!254 = metadata !{i32 786688, metadata !205, metadata !"desc", metadata !48, i32 1192, metadata !51, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [desc] [line 1192]
!255 = metadata !{i32 786688, metadata !205, metadata !"count", metadata !48, i32 1193, metadata !51, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [count] [line 1193]
!256 = metadata !{i32 786688, metadata !205, metadata !"status", metadata !48, i32 1194, metadata !51, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [status] [line 1194]
!257 = metadata !{i32 786688, metadata !258, metadata !"e", metadata !48, i32 1220, metadata !51, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [e] [line 1220]
!258 = metadata !{i32 786443, metadata !1, metadata !259, i32 1219, i32 0, i32 124} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!259 = metadata !{i32 786443, metadata !1, metadata !260, i32 1218, i32 0, i32 123} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!260 = metadata !{i32 786443, metadata !1, metadata !261, i32 1202, i32 0, i32 118} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!261 = metadata !{i32 786443, metadata !1, metadata !205, i32 1196, i32 0, i32 116} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!262 = metadata !{i32 786688, metadata !263, metadata !"required_offset", metadata !48, i32 1292, metadata !267, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [required_offset] [line 1292]
!263 = metadata !{i32 786443, metadata !1, metadata !264, i32 1291, i32 0, i32 145} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!264 = metadata !{i32 786443, metadata !1, metadata !265, i32 1290, i32 0, i32 144} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!265 = metadata !{i32 786443, metadata !1, metadata !266, i32 1269, i32 0, i32 136} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!266 = metadata !{i32 786443, metadata !1, metadata !205, i32 1266, i32 0, i32 135} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!267 = metadata !{i32 786454, metadata !268, null, metadata !"off_t", i32 87, i64 0, i64 0, i64 0, i32 0, metadata !106} ; [ DW_TAG_typedef ] [off_t] [line 87, size 0, align 0, offset 0] [from __off_t]
!268 = metadata !{metadata !"/usr/include/x86_64-linux-gnu/sys/types.h", metadata !"/home/kostas/workspace/test/grep-2.7/src"}
!269 = metadata !{i32 786478, metadata !270, metadata !271, metadata !"fputc_unlocked", metadata !"fputc_unlocked", metadata !"", i32 89, metadata !272, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, null, null, null, metadata !274, i32 90} ; [ DW_TAG_subprogram ] [line 89] [def] [scope 90] [fputc_unlocked]
!270 = metadata !{metadata !"/usr/include/x86_64-linux-gnu/bits/stdio.h", metadata !"/home/kostas/workspace/test/grep-2.7/src"}
!271 = metadata !{i32 786473, metadata !270}      ; [ DW_TAG_file_type ] [/home/kostas/workspace/test/grep-2.7/src//usr/include/x86_64-linux-gnu/bits/stdio.h]
!272 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !273, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!273 = metadata !{metadata !51, metadata !51, metadata !76}
!274 = metadata !{metadata !275, metadata !276}
!275 = metadata !{i32 786689, metadata !269, metadata !"__c", metadata !271, i32 16777305, metadata !51, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [__c] [line 89]
!276 = metadata !{i32 786689, metadata !269, metadata !"__stream", metadata !271, i32 33554521, metadata !76, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [__stream] [line 89]
!277 = metadata !{i32 786478, metadata !1, metadata !48, metadata !"print_sep", metadata !"print_sep", metadata !"", i32 651, metadata !278, i1 true, i1 true, i32 0, i32 0, null, i32 256, i1 true, null, null, null, metadata !280, i32 652} ; [ DW_TAG_subprogram ] [line 651] [local] [def] [scope 652] [print_sep]
!278 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !279, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!279 = metadata !{null, metadata !59}
!280 = metadata !{metadata !281}
!281 = metadata !{i32 786689, metadata !277, metadata !"sep", metadata !48, i32 16777867, metadata !59, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [sep] [line 651]
!282 = metadata !{i32 786478, metadata !1, metadata !48, metadata !"print_filename", metadata !"print_filename", metadata !"", i32 642, metadata !283, i1 true, i1 true, i32 0, i32 0, null, i32 256, i1 true, null, null, null, metadata !45, i32 643} ; [ DW_TAG_subprogram ] [line 642] [local] [def] [scope 643] [print_filename]
!283 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !284, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!284 = metadata !{null}
!285 = metadata !{i32 786478, metadata !1, metadata !48, metadata !"grep", metadata !"grep", metadata !"", i32 1059, metadata !286, i1 true, i1 true, i32 0, i32 0, null, i32 256, i1 true, null, null, null, metadata !288, i32 1060} ; [ DW_TAG_subprogram ] [line 1059] [local] [def] [scope 1060] [grep]
!286 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !287, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!287 = metadata !{metadata !51, metadata !51, metadata !183, metadata !208}
!288 = metadata !{metadata !289, metadata !290, metadata !291, metadata !292, metadata !293, metadata !294, metadata !295, metadata !296, metadata !297, metadata !298, metadata !299, metadata !300}
!289 = metadata !{i32 786689, metadata !285, metadata !"fd", metadata !48, i32 16778275, metadata !51, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [fd] [line 1059]
!290 = metadata !{i32 786689, metadata !285, metadata !"file", metadata !48, i32 33555491, metadata !183, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [file] [line 1059]
!291 = metadata !{i32 786689, metadata !285, metadata !"stats", metadata !48, i32 50332707, metadata !208, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [stats] [line 1059]
!292 = metadata !{i32 786688, metadata !285, metadata !"nlines", metadata !48, i32 1061, metadata !51, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [nlines] [line 1061]
!293 = metadata !{i32 786688, metadata !285, metadata !"i", metadata !48, i32 1061, metadata !51, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 1061]
!294 = metadata !{i32 786688, metadata !285, metadata !"not_text", metadata !48, i32 1062, metadata !51, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [not_text] [line 1062]
!295 = metadata !{i32 786688, metadata !285, metadata !"residue", metadata !48, i32 1063, metadata !65, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [residue] [line 1063]
!296 = metadata !{i32 786688, metadata !285, metadata !"save", metadata !48, i32 1063, metadata !65, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [save] [line 1063]
!297 = metadata !{i32 786688, metadata !285, metadata !"oldc", metadata !48, i32 1064, metadata !59, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [oldc] [line 1064]
!298 = metadata !{i32 786688, metadata !285, metadata !"beg", metadata !48, i32 1065, metadata !58, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [beg] [line 1065]
!299 = metadata !{i32 786688, metadata !285, metadata !"lim", metadata !48, i32 1066, metadata !58, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [lim] [line 1066]
!300 = metadata !{i32 786688, metadata !285, metadata !"eol", metadata !48, i32 1067, metadata !59, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [eol] [line 1067]
!301 = metadata !{i32 786478, metadata !1, metadata !48, metadata !"nlscan", metadata !"nlscan", metadata !"", i32 625, metadata !302, i1 true, i1 true, i32 0, i32 0, null, i32 256, i1 true, null, null, null, metadata !304, i32 626} ; [ DW_TAG_subprogram ] [line 625] [local] [def] [scope 626] [nlscan]
!302 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !303, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!303 = metadata !{null, metadata !183}
!304 = metadata !{metadata !305, metadata !306, metadata !307}
!305 = metadata !{i32 786689, metadata !301, metadata !"lim", metadata !48, i32 16777841, metadata !183, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [lim] [line 625]
!306 = metadata !{i32 786688, metadata !301, metadata !"newlines", metadata !48, i32 627, metadata !65, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [newlines] [line 627]
!307 = metadata !{i32 786688, metadata !301, metadata !"beg", metadata !48, i32 628, metadata !183, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [beg] [line 628]
!308 = metadata !{i32 786478, metadata !1, metadata !48, metadata !"add_count", metadata !"add_count", metadata !"", i32 616, metadata !309, i1 true, i1 true, i32 0, i32 0, null, i32 256, i1 true, null, null, null, metadata !311, i32 617} ; [ DW_TAG_subprogram ] [line 616] [local] [def] [scope 617] [add_count]
!309 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !310, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!310 = metadata !{metadata !157, metadata !157, metadata !157}
!311 = metadata !{metadata !312, metadata !313, metadata !314}
!312 = metadata !{i32 786689, metadata !308, metadata !"a", metadata !48, i32 16777832, metadata !157, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [a] [line 616]
!313 = metadata !{i32 786689, metadata !308, metadata !"b", metadata !48, i32 33555048, metadata !157, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [b] [line 616]
!314 = metadata !{i32 786688, metadata !308, metadata !"sum", metadata !48, i32 618, metadata !157, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [sum] [line 618]
!315 = metadata !{i32 786478, metadata !1, metadata !48, metadata !"prpending", metadata !"prpending", metadata !"", i32 873, metadata !302, i1 true, i1 true, i32 0, i32 0, null, i32 256, i1 true, void (i8*)* @prpending, null, null, metadata !316, i32 874} ; [ DW_TAG_subprogram ] [line 873] [local] [def] [scope 874] [prpending]
!316 = metadata !{metadata !317, metadata !318, metadata !320}
!317 = metadata !{i32 786689, metadata !315, metadata !"lim", metadata !48, i32 16778089, metadata !183, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [lim] [line 873]
!318 = metadata !{i32 786688, metadata !319, metadata !"nl", metadata !48, i32 879, metadata !183, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [nl] [line 879]
!319 = metadata !{i32 786443, metadata !1, metadata !315, i32 878, i32 0, i32 193} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!320 = metadata !{i32 786688, metadata !319, metadata !"match_size", metadata !48, i32 880, metadata !65, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [match_size] [line 880]
!321 = metadata !{i32 786478, metadata !1, metadata !48, metadata !"prline", metadata !"prline", metadata !"", i32 824, metadata !322, i1 true, i1 true, i32 0, i32 0, null, i32 256, i1 true, void (i8*, i8*, i32)* @prline, null, null, metadata !324, i32 825} ; [ DW_TAG_subprogram ] [line 824] [local] [def] [scope 825] [prline]
!322 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !323, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!323 = metadata !{null, metadata !183, metadata !183, metadata !51}
!324 = metadata !{metadata !325, metadata !326, metadata !327, metadata !328, metadata !329, metadata !330}
!325 = metadata !{i32 786689, metadata !321, metadata !"beg", metadata !48, i32 16778040, metadata !183, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [beg] [line 824]
!326 = metadata !{i32 786689, metadata !321, metadata !"lim", metadata !48, i32 33555256, metadata !183, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [lim] [line 824]
!327 = metadata !{i32 786689, metadata !321, metadata !"sep", metadata !48, i32 50332472, metadata !51, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [sep] [line 824]
!328 = metadata !{i32 786688, metadata !321, metadata !"matching", metadata !48, i32 826, metadata !51, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [matching] [line 826]
!329 = metadata !{i32 786688, metadata !321, metadata !"line_color", metadata !48, i32 827, metadata !183, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [line_color] [line 827]
!330 = metadata !{i32 786688, metadata !321, metadata !"match_color", metadata !48, i32 828, metadata !183, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [match_color] [line 828]
!331 = metadata !{i32 786478, metadata !270, metadata !271, metadata !"ferror_unlocked", metadata !"ferror_unlocked", metadata !"", i32 133, metadata !332, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, null, null, null, metadata !334, i32 134} ; [ DW_TAG_subprogram ] [line 133] [def] [scope 134] [ferror_unlocked]
!332 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !333, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!333 = metadata !{metadata !51, metadata !76}
!334 = metadata !{metadata !335}
!335 = metadata !{i32 786689, metadata !331, metadata !"__stream", metadata !271, i32 16777349, metadata !76, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [__stream] [line 133]
!336 = metadata !{i32 786478, metadata !1, metadata !48, metadata !"print_line_tail", metadata !"print_line_tail", metadata !"", i32 803, metadata !337, i1 true, i1 true, i32 0, i32 0, null, i32 256, i1 true, null, null, null, metadata !339, i32 804} ; [ DW_TAG_subprogram ] [line 803] [local] [def] [scope 804] [print_line_tail]
!337 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !338, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!338 = metadata !{metadata !183, metadata !183, metadata !183, metadata !183}
!339 = metadata !{metadata !340, metadata !341, metadata !342, metadata !343, metadata !345}
!340 = metadata !{i32 786689, metadata !336, metadata !"beg", metadata !48, i32 16778019, metadata !183, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [beg] [line 803]
!341 = metadata !{i32 786689, metadata !336, metadata !"lim", metadata !48, i32 33555235, metadata !183, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [lim] [line 803]
!342 = metadata !{i32 786689, metadata !336, metadata !"line_color", metadata !48, i32 50332451, metadata !183, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [line_color] [line 803]
!343 = metadata !{i32 786688, metadata !344, metadata !"eol_size", metadata !48, i32 805, metadata !65, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [eol_size] [line 805]
!344 = metadata !{i32 786443, metadata !1, metadata !336} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!345 = metadata !{i32 786688, metadata !344, metadata !"tail_size", metadata !48, i32 806, metadata !65, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [tail_size] [line 806]
!346 = metadata !{i32 786478, metadata !1, metadata !48, metadata !"print_line_middle", metadata !"print_line_middle", metadata !"", i32 740, metadata !347, i1 true, i1 true, i32 0, i32 0, null, i32 256, i1 true, null, null, null, metadata !349, i32 742} ; [ DW_TAG_subprogram ] [line 740] [local] [def] [scope 742] [print_line_middle]
!347 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !348, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!348 = metadata !{metadata !183, metadata !183, metadata !183, metadata !183, metadata !183}
!349 = metadata !{metadata !350, metadata !351, metadata !352, metadata !353, metadata !354, metadata !355, metadata !356, metadata !357, metadata !358}
!350 = metadata !{i32 786689, metadata !346, metadata !"beg", metadata !48, i32 16777956, metadata !183, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [beg] [line 740]
!351 = metadata !{i32 786689, metadata !346, metadata !"lim", metadata !48, i32 33555172, metadata !183, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [lim] [line 740]
!352 = metadata !{i32 786689, metadata !346, metadata !"line_color", metadata !48, i32 50332389, metadata !183, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [line_color] [line 741]
!353 = metadata !{i32 786689, metadata !346, metadata !"match_color", metadata !48, i32 67109605, metadata !183, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [match_color] [line 741]
!354 = metadata !{i32 786688, metadata !346, metadata !"match_size", metadata !48, i32 743, metadata !65, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [match_size] [line 743]
!355 = metadata !{i32 786688, metadata !346, metadata !"match_offset", metadata !48, i32 744, metadata !65, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [match_offset] [line 744]
!356 = metadata !{i32 786688, metadata !346, metadata !"cur", metadata !48, i32 745, metadata !183, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [cur] [line 745]
!357 = metadata !{i32 786688, metadata !346, metadata !"mid", metadata !48, i32 746, metadata !183, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [mid] [line 746]
!358 = metadata !{i32 786688, metadata !359, metadata !"b", metadata !48, i32 752, metadata !183, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [b] [line 752]
!359 = metadata !{i32 786443, metadata !1, metadata !346, i32 751, i32 0, i32 211} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!360 = metadata !{i32 786478, metadata !1, metadata !48, metadata !"print_line_head", metadata !"print_line_head", metadata !"", i32 687, metadata !322, i1 true, i1 true, i32 0, i32 0, null, i32 256, i1 true, void (i8*, i8*, i32)* @print_line_head, null, null, metadata !361, i32 688} ; [ DW_TAG_subprogram ] [line 687] [local] [def] [scope 688] [print_line_head]
!361 = metadata !{metadata !362, metadata !363, metadata !364, metadata !365, metadata !366}
!362 = metadata !{i32 786689, metadata !360, metadata !"beg", metadata !48, i32 16777903, metadata !183, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [beg] [line 687]
!363 = metadata !{i32 786689, metadata !360, metadata !"lim", metadata !48, i32 33555119, metadata !183, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [lim] [line 687]
!364 = metadata !{i32 786689, metadata !360, metadata !"sep", metadata !48, i32 50332335, metadata !51, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [sep] [line 687]
!365 = metadata !{i32 786688, metadata !360, metadata !"pending_sep", metadata !48, i32 689, metadata !51, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [pending_sep] [line 689]
!366 = metadata !{i32 786688, metadata !367, metadata !"pos", metadata !48, i32 716, metadata !157, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [pos] [line 716]
!367 = metadata !{i32 786443, metadata !1, metadata !368, i32 715, i32 0, i32 239} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!368 = metadata !{i32 786443, metadata !1, metadata !360, i32 714, i32 0, i32 238} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!369 = metadata !{i32 786478, metadata !1, metadata !48, metadata !"print_offset", metadata !"print_offset", metadata !"", i32 660, metadata !370, i1 true, i1 true, i32 0, i32 0, null, i32 256, i1 true, void (i64, i32, i8*)* @print_offset, null, null, metadata !372, i32 661} ; [ DW_TAG_subprogram ] [line 660] [local] [def] [scope 661] [print_offset]
!370 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !371, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!371 = metadata !{null, metadata !157, metadata !51, metadata !183}
!372 = metadata !{metadata !373, metadata !374, metadata !375, metadata !376, metadata !380}
!373 = metadata !{i32 786689, metadata !369, metadata !"pos", metadata !48, i32 16777876, metadata !157, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [pos] [line 660]
!374 = metadata !{i32 786689, metadata !369, metadata !"min_width", metadata !48, i32 33555092, metadata !51, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [min_width] [line 660]
!375 = metadata !{i32 786689, metadata !369, metadata !"color", metadata !48, i32 50332308, metadata !183, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [color] [line 660]
!376 = metadata !{i32 786688, metadata !369, metadata !"buf", metadata !48, i32 665, metadata !377, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [buf] [line 665]
!377 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 512, i64 8, i32 0, i32 0, metadata !59, metadata !378, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 512, align 8, offset 0] [from char]
!378 = metadata !{metadata !379}
!379 = metadata !{i32 786465, i64 0, i64 64}      ; [ DW_TAG_subrange_type ] [0, 63]
!380 = metadata !{i32 786688, metadata !369, metadata !"p", metadata !48, i32 666, metadata !58, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [p] [line 666]
!381 = metadata !{i32 786478, metadata !1, metadata !48, metadata !"grepbuf", metadata !"grepbuf", metadata !"", i32 1006, metadata !382, i1 true, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i8*, i8*)* @grepbuf, null, null, metadata !384, i32 1007} ; [ DW_TAG_subprogram ] [line 1006] [local] [def] [scope 1007] [grepbuf]
!382 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !383, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!383 = metadata !{metadata !51, metadata !183, metadata !183}
!384 = metadata !{metadata !385, metadata !386, metadata !387, metadata !388, metadata !389, metadata !390, metadata !391, metadata !392, metadata !394}
!385 = metadata !{i32 786689, metadata !381, metadata !"beg", metadata !48, i32 16778222, metadata !183, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [beg] [line 1006]
!386 = metadata !{i32 786689, metadata !381, metadata !"lim", metadata !48, i32 33555438, metadata !183, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [lim] [line 1006]
!387 = metadata !{i32 786688, metadata !381, metadata !"nlines", metadata !48, i32 1008, metadata !51, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [nlines] [line 1008]
!388 = metadata !{i32 786688, metadata !381, metadata !"n", metadata !48, i32 1008, metadata !51, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [n] [line 1008]
!389 = metadata !{i32 786688, metadata !381, metadata !"p", metadata !48, i32 1009, metadata !183, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [p] [line 1009]
!390 = metadata !{i32 786688, metadata !381, metadata !"match_offset", metadata !48, i32 1010, metadata !65, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [match_offset] [line 1010]
!391 = metadata !{i32 786688, metadata !381, metadata !"match_size", metadata !48, i32 1011, metadata !65, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [match_size] [line 1011]
!392 = metadata !{i32 786688, metadata !393, metadata !"b", metadata !48, i32 1018, metadata !183, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [b] [line 1018]
!393 = metadata !{i32 786443, metadata !1, metadata !381, i32 1017, i32 0, i32 250} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!394 = metadata !{i32 786688, metadata !393, metadata !"endp", metadata !48, i32 1019, metadata !183, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [endp] [line 1019]
!395 = metadata !{i32 786478, metadata !1, metadata !48, metadata !"prtext", metadata !"prtext", metadata !"", i32 895, metadata !396, i1 true, i1 true, i32 0, i32 0, null, i32 256, i1 true, void (i8*, i8*, i32*)* @prtext, null, null, metadata !399, i32 896} ; [ DW_TAG_subprogram ] [line 895] [local] [def] [scope 896] [prtext]
!396 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !397, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!397 = metadata !{null, metadata !183, metadata !183, metadata !398}
!398 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !51} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from int]
!399 = metadata !{metadata !400, metadata !401, metadata !402, metadata !403, metadata !404, metadata !405, metadata !406, metadata !407, metadata !408, metadata !412}
!400 = metadata !{i32 786689, metadata !395, metadata !"beg", metadata !48, i32 16778111, metadata !183, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [beg] [line 895]
!401 = metadata !{i32 786689, metadata !395, metadata !"lim", metadata !48, i32 33555327, metadata !183, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [lim] [line 895]
!402 = metadata !{i32 786689, metadata !395, metadata !"nlinesp", metadata !48, i32 50332543, metadata !398, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [nlinesp] [line 895]
!403 = metadata !{i32 786688, metadata !395, metadata !"bp", metadata !48, i32 898, metadata !183, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [bp] [line 898]
!404 = metadata !{i32 786688, metadata !395, metadata !"p", metadata !48, i32 898, metadata !183, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [p] [line 898]
!405 = metadata !{i32 786688, metadata !395, metadata !"eol", metadata !48, i32 899, metadata !59, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [eol] [line 899]
!406 = metadata !{i32 786688, metadata !395, metadata !"i", metadata !48, i32 900, metadata !51, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 900]
!407 = metadata !{i32 786688, metadata !395, metadata !"n", metadata !48, i32 900, metadata !51, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [n] [line 900]
!408 = metadata !{i32 786688, metadata !409, metadata !"nl", metadata !48, i32 930, metadata !183, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [nl] [line 930]
!409 = metadata !{i32 786443, metadata !1, metadata !410, i32 929, i32 0, i32 273} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!410 = metadata !{i32 786443, metadata !1, metadata !411, i32 908, i32 0, i32 264} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!411 = metadata !{i32 786443, metadata !1, metadata !395, i32 907, i32 0, i32 263} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!412 = metadata !{i32 786688, metadata !413, metadata !"nl", metadata !48, i32 942, metadata !183, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [nl] [line 942]
!413 = metadata !{i32 786443, metadata !1, metadata !414, i32 941, i32 0, i32 277} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!414 = metadata !{i32 786443, metadata !1, metadata !415, i32 940, i32 0, i32 276} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!415 = metadata !{i32 786443, metadata !1, metadata !416, i32 938, i32 0, i32 275} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!416 = metadata !{i32 786443, metadata !1, metadata !395, i32 937, i32 0, i32 274} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!417 = metadata !{i32 786478, metadata !1, metadata !48, metadata !"do_execute", metadata !"do_execute", metadata !"", i32 962, metadata !418, i1 true, i1 true, i32 0, i32 0, null, i32 256, i1 true, null, null, null, metadata !421, i32 963} ; [ DW_TAG_subprogram ] [line 962] [local] [def] [scope 963] [do_execute]
!418 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !419, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!419 = metadata !{metadata !65, metadata !183, metadata !65, metadata !420, metadata !183}
!420 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !65} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from size_t]
!421 = metadata !{metadata !422, metadata !423, metadata !424, metadata !425, metadata !426, metadata !427, metadata !428, metadata !431}
!422 = metadata !{i32 786689, metadata !417, metadata !"buf", metadata !48, i32 16778178, metadata !183, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [buf] [line 962]
!423 = metadata !{i32 786689, metadata !417, metadata !"size", metadata !48, i32 33555394, metadata !65, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [size] [line 962]
!424 = metadata !{i32 786689, metadata !417, metadata !"match_size", metadata !48, i32 50332610, metadata !420, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [match_size] [line 962]
!425 = metadata !{i32 786689, metadata !417, metadata !"start_ptr", metadata !48, i32 67109826, metadata !183, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [start_ptr] [line 962]
!426 = metadata !{i32 786688, metadata !417, metadata !"result", metadata !48, i32 964, metadata !65, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [result] [line 964]
!427 = metadata !{i32 786688, metadata !417, metadata !"line_next", metadata !48, i32 965, metadata !183, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [line_next] [line 965]
!428 = metadata !{i32 786688, metadata !429, metadata !"line_buf", metadata !48, i32 984, metadata !183, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [line_buf] [line 984]
!429 = metadata !{i32 786443, metadata !1, metadata !430, i32 983, i32 0, i32 282} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!430 = metadata !{i32 786443, metadata !1, metadata !417, i32 982, i32 0, i32 281} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!431 = metadata !{i32 786688, metadata !429, metadata !"line_end", metadata !48, i32 985, metadata !183, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [line_end] [line 985]
!432 = metadata !{i32 786478, metadata !1, metadata !48, metadata !"fillbuf", metadata !"fillbuf", metadata !"", i32 486, metadata !433, i1 true, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i64, %struct.stats*)* @fillbuf, null, null, metadata !435, i32 487} ; [ DW_TAG_subprogram ] [line 486] [local] [def] [scope 487] [fillbuf]
!433 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !434, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!434 = metadata !{metadata !51, metadata !65, metadata !212}
!435 = metadata !{metadata !436, metadata !437, metadata !438, metadata !439, metadata !440, metadata !441, metadata !442, metadata !443, metadata !446, metadata !447, metadata !448, metadata !449, metadata !452, metadata !453}
!436 = metadata !{i32 786689, metadata !432, metadata !"save", metadata !48, i32 16777702, metadata !65, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [save] [line 486]
!437 = metadata !{i32 786689, metadata !432, metadata !"stats", metadata !48, i32 33554918, metadata !212, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [stats] [line 486]
!438 = metadata !{i32 786688, metadata !432, metadata !"fillsize", metadata !48, i32 488, metadata !65, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [fillsize] [line 488]
!439 = metadata !{i32 786688, metadata !432, metadata !"cc", metadata !48, i32 489, metadata !51, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [cc] [line 489]
!440 = metadata !{i32 786688, metadata !432, metadata !"readbuf", metadata !48, i32 490, metadata !58, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [readbuf] [line 490]
!441 = metadata !{i32 786688, metadata !432, metadata !"readsize", metadata !48, i32 491, metadata !65, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [readsize] [line 491]
!442 = metadata !{i32 786688, metadata !432, metadata !"saved_offset", metadata !48, i32 495, metadata !65, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [saved_offset] [line 495]
!443 = metadata !{i32 786688, metadata !444, metadata !"minsize", metadata !48, i32 504, metadata !65, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [minsize] [line 504]
!444 = metadata !{i32 786443, metadata !1, metadata !445, i32 503, i32 0, i32 288} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!445 = metadata !{i32 786443, metadata !1, metadata !432, i32 497, i32 0, i32 286} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!446 = metadata !{i32 786688, metadata !444, metadata !"newsize", metadata !48, i32 505, metadata !65, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [newsize] [line 505]
!447 = metadata !{i32 786688, metadata !444, metadata !"newalloc", metadata !48, i32 506, metadata !65, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [newalloc] [line 506]
!448 = metadata !{i32 786688, metadata !444, metadata !"newbuf", metadata !48, i32 507, metadata !58, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [newbuf] [line 507]
!449 = metadata !{i32 786688, metadata !450, metadata !"to_be_read", metadata !48, i32 521, metadata !267, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [to_be_read] [line 521]
!450 = metadata !{i32 786443, metadata !1, metadata !451, i32 520, i32 0, i32 292} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!451 = metadata !{i32 786443, metadata !1, metadata !444, i32 519, i32 0, i32 291} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!452 = metadata !{i32 786688, metadata !450, metadata !"maxsize_off", metadata !48, i32 522, metadata !267, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [maxsize_off] [line 522]
!453 = metadata !{i32 786688, metadata !454, metadata !"bytesread", metadata !48, i32 551, metadata !456, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [bytesread] [line 551]
!454 = metadata !{i32 786443, metadata !1, metadata !455, i32 550, i32 0, i32 297} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!455 = metadata !{i32 786443, metadata !1, metadata !432, i32 549, i32 0, i32 296} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!456 = metadata !{i32 786454, metadata !268, null, metadata !"ssize_t", i32 110, i64 0, i64 0, i64 0, i32 0, metadata !457} ; [ DW_TAG_typedef ] [ssize_t] [line 110, size 0, align 0, offset 0] [from __ssize_t]
!457 = metadata !{i32 786454, metadata !107, null, metadata !"__ssize_t", i32 180, i64 0, i64 0, i64 0, i32 0, metadata !108} ; [ DW_TAG_typedef ] [__ssize_t] [line 180, size 0, align 0, offset 0] [from long int]
!458 = metadata !{i32 786478, metadata !1, metadata !48, metadata !"reset", metadata !"reset", metadata !"", i32 449, metadata !286, i1 true, i1 true, i32 0, i32 0, null, i32 256, i1 true, null, null, null, metadata !459, i32 450} ; [ DW_TAG_subprogram ] [line 449] [local] [def] [scope 450] [reset]
!459 = metadata !{metadata !460, metadata !461, metadata !462}
!460 = metadata !{i32 786689, metadata !458, metadata !"fd", metadata !48, i32 16777665, metadata !51, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [fd] [line 449]
!461 = metadata !{i32 786689, metadata !458, metadata !"file", metadata !48, i32 33554881, metadata !183, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [file] [line 449]
!462 = metadata !{i32 786689, metadata !458, metadata !"stats", metadata !48, i32 50332097, metadata !208, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [stats] [line 449]
!463 = metadata !{i32 786478, metadata !1, metadata !48, metadata !"grepdir", metadata !"grepdir", metadata !"", i32 1311, metadata !464, i1 true, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i8*, %struct.stats*)* @grepdir, null, null, metadata !466, i32 1312} ; [ DW_TAG_subprogram ] [line 1311] [local] [def] [scope 1312] [grepdir]
!464 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !465, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!465 = metadata !{metadata !51, metadata !183, metadata !212}
!466 = metadata !{metadata !467, metadata !468, metadata !469, metadata !470, metadata !471, metadata !472, metadata !475, metadata !476, metadata !477, metadata !478, metadata !479}
!467 = metadata !{i32 786689, metadata !463, metadata !"dir", metadata !48, i32 16778527, metadata !183, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [dir] [line 1311]
!468 = metadata !{i32 786689, metadata !463, metadata !"stats", metadata !48, i32 33555743, metadata !212, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [stats] [line 1311]
!469 = metadata !{i32 786688, metadata !463, metadata !"ancestor", metadata !48, i32 1313, metadata !212, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [ancestor] [line 1313]
!470 = metadata !{i32 786688, metadata !463, metadata !"name_space", metadata !48, i32 1314, metadata !58, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [name_space] [line 1314]
!471 = metadata !{i32 786688, metadata !463, metadata !"status", metadata !48, i32 1315, metadata !51, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [status] [line 1315]
!472 = metadata !{i32 786688, metadata !473, metadata !"dirlen", metadata !48, i32 1347, metadata !65, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [dirlen] [line 1347]
!473 = metadata !{i32 786443, metadata !1, metadata !474, i32 1346, i32 0, i32 318} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!474 = metadata !{i32 786443, metadata !1, metadata !463, i32 1338, i32 0, i32 315} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!475 = metadata !{i32 786688, metadata !473, metadata !"needs_slash", metadata !48, i32 1348, metadata !51, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [needs_slash] [line 1348]
!476 = metadata !{i32 786688, metadata !473, metadata !"file", metadata !48, i32 1350, metadata !58, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [file] [line 1350]
!477 = metadata !{i32 786688, metadata !473, metadata !"namep", metadata !48, i32 1351, metadata !183, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [namep] [line 1351]
!478 = metadata !{i32 786688, metadata !473, metadata !"child", metadata !48, i32 1352, metadata !209, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [child] [line 1352]
!479 = metadata !{i32 786688, metadata !480, metadata !"namelen", metadata !48, i32 1357, metadata !65, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [namelen] [line 1357]
!480 = metadata !{i32 786443, metadata !1, metadata !473, i32 1356, i32 0, i32 319} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!481 = metadata !{i32 786478, metadata !1, metadata !48, metadata !"suppressible_error", metadata !"suppressible_error", metadata !"", i32 399, metadata !482, i1 true, i1 true, i32 0, i32 0, null, i32 256, i1 true, null, null, null, metadata !484, i32 400} ; [ DW_TAG_subprogram ] [line 399] [local] [def] [scope 400] [suppressible_error]
!482 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !483, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!483 = metadata !{null, metadata !183, metadata !51}
!484 = metadata !{metadata !485, metadata !486}
!485 = metadata !{i32 786689, metadata !481, metadata !"mesg", metadata !48, i32 16777615, metadata !183, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [mesg] [line 399]
!486 = metadata !{i32 786689, metadata !481, metadata !"errnum", metadata !48, i32 33554831, metadata !51, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [errnum] [line 399]
!487 = metadata !{i32 786478, metadata !488, metadata !489, metadata !"stat", metadata !"stat", metadata !"", i32 455, metadata !490, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, null, null, null, metadata !493, i32 456} ; [ DW_TAG_subprogram ] [line 455] [def] [scope 456] [stat]
!488 = metadata !{metadata !"/usr/include/x86_64-linux-gnu/sys/stat.h", metadata !"/home/kostas/workspace/test/grep-2.7/src"}
!489 = metadata !{i32 786473, metadata !488}      ; [ DW_TAG_file_type ] [/home/kostas/workspace/test/grep-2.7/src//usr/include/x86_64-linux-gnu/sys/stat.h]
!490 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !491, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!491 = metadata !{metadata !51, metadata !183, metadata !492}
!492 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !215} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from stat]
!493 = metadata !{metadata !494, metadata !495}
!494 = metadata !{i32 786689, metadata !487, metadata !"__path", metadata !489, i32 16777671, metadata !183, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [__path] [line 455]
!495 = metadata !{i32 786689, metadata !487, metadata !"__statbuf", metadata !489, i32 33554887, metadata !492, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [__statbuf] [line 455]
!496 = metadata !{i32 786478, metadata !1, metadata !48, metadata !"set_limits", metadata !"set_limits", metadata !"", i32 1529, metadata !283, i1 true, i1 true, i32 0, i32 0, null, i32 256, i1 true, null, null, null, metadata !45, i32 1530} ; [ DW_TAG_subprogram ] [line 1529] [local] [def] [scope 1530] [set_limits]
!497 = metadata !{i32 786478, metadata !1, metadata !48, metadata !"parse_grep_colors", metadata !"parse_grep_colors", metadata !"", i32 1673, metadata !283, i1 true, i1 true, i32 0, i32 0, null, i32 256, i1 true, null, null, null, metadata !498, i32 1674} ; [ DW_TAG_subprogram ] [line 1673] [local] [def] [scope 1674] [parse_grep_colors]
!498 = metadata !{metadata !499, metadata !500, metadata !501, metadata !502, metadata !503, metadata !507, metadata !518, metadata !522, metadata !523}
!499 = metadata !{i32 786688, metadata !497, metadata !"p", metadata !48, i32 1675, metadata !183, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [p] [line 1675]
!500 = metadata !{i32 786688, metadata !497, metadata !"q", metadata !48, i32 1676, metadata !58, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [q] [line 1676]
!501 = metadata !{i32 786688, metadata !497, metadata !"name", metadata !48, i32 1677, metadata !58, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [name] [line 1677]
!502 = metadata !{i32 786688, metadata !497, metadata !"val", metadata !48, i32 1678, metadata !58, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [val] [line 1678]
!503 = metadata !{i32 786688, metadata !504, metadata !"c", metadata !48, i32 1696, metadata !59, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [c] [line 1696]
!504 = metadata !{i32 786443, metadata !1, metadata !505, i32 1695, i32 0, i32 325} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!505 = metadata !{i32 786443, metadata !1, metadata !506, i32 1694, i32 0, i32 324} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!506 = metadata !{i32 786443, metadata !1, metadata !497, i32 1693, i32 0, i32 323} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!507 = metadata !{i32 786688, metadata !504, metadata !"cap", metadata !48, i32 1697, metadata !508, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [cap] [line 1697]
!508 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !509} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from color_cap]
!509 = metadata !{i32 786451, metadata !1, null, metadata !"color_cap", i32 219, i64 192, i64 64, i32 0, i32 0, null, metadata !510, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [color_cap] [line 219, size 192, align 64, offset 0] [def] [from ]
!510 = metadata !{metadata !511, metadata !512, metadata !514}
!511 = metadata !{i32 786445, metadata !1, metadata !509, metadata !"name", i32 221, i64 64, i64 64, i64 0, i32 0, metadata !183} ; [ DW_TAG_member ] [name] [line 221, size 64, align 64, offset 0] [from ]
!512 = metadata !{i32 786445, metadata !1, metadata !509, metadata !"var", i32 222, i64 64, i64 64, i64 64, i32 0, metadata !513} ; [ DW_TAG_member ] [var] [line 222, size 64, align 64, offset 64] [from ]
!513 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !183} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!514 = metadata !{i32 786445, metadata !1, metadata !509, metadata !"fct", i32 223, i64 64, i64 64, i64 128, i32 0, metadata !515} ; [ DW_TAG_member ] [fct] [line 223, size 64, align 64, offset 128] [from ]
!515 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !516} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!516 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !517, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!517 = metadata !{metadata !183}
!518 = metadata !{i32 786688, metadata !519, metadata !"__s1_len", metadata !48, i32 1703, metadata !65, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__s1_len] [line 1703]
!519 = metadata !{i32 786443, metadata !1, metadata !520, i32 1703, i32 0, i32 328} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!520 = metadata !{i32 786443, metadata !1, metadata !521, i32 1703, i32 0, i32 327} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!521 = metadata !{i32 786443, metadata !1, metadata !504, i32 1702, i32 0, i32 326} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!522 = metadata !{i32 786688, metadata !519, metadata !"__s2_len", metadata !48, i32 1703, metadata !65, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__s2_len] [line 1703]
!523 = metadata !{i32 786688, metadata !524, metadata !"err_str", metadata !48, i32 1723, metadata !183, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [err_str] [line 1723]
!524 = metadata !{i32 786443, metadata !1, metadata !525, i32 1722, i32 0, i32 336} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!525 = metadata !{i32 786443, metadata !1, metadata !504, i32 1721, i32 0, i32 335} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!526 = metadata !{i32 786478, metadata !1, metadata !48, metadata !"color_cap_ne_fct", metadata !"color_cap_ne_fct", metadata !"", i32 245, metadata !516, i1 true, i1 true, i32 0, i32 0, null, i32 256, i1 true, i8* ()* @color_cap_ne_fct, null, null, metadata !45, i32 246} ; [ DW_TAG_subprogram ] [line 245] [local] [def] [scope 246] [color_cap_ne_fct]
!527 = metadata !{i32 786478, metadata !1, metadata !48, metadata !"color_cap_rv_fct", metadata !"color_cap_rv_fct", metadata !"", i32 236, metadata !516, i1 true, i1 true, i32 0, i32 0, null, i32 256, i1 true, i8* ()* @color_cap_rv_fct, null, null, metadata !45, i32 237} ; [ DW_TAG_subprogram ] [line 236] [local] [def] [scope 237] [color_cap_rv_fct]
!528 = metadata !{i32 786478, metadata !1, metadata !48, metadata !"color_cap_mt_fct", metadata !"color_cap_mt_fct", metadata !"", i32 227, metadata !516, i1 true, i1 true, i32 0, i32 0, null, i32 256, i1 true, i8* ()* @color_cap_mt_fct, null, null, metadata !45, i32 228} ; [ DW_TAG_subprogram ] [line 227] [local] [def] [scope 228] [color_cap_mt_fct]
!529 = metadata !{i32 786478, metadata !270, metadata !271, metadata !"feof_unlocked", metadata !"feof_unlocked", metadata !"", i32 126, metadata !332, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, null, null, null, metadata !530, i32 127} ; [ DW_TAG_subprogram ] [line 126] [def] [scope 127] [feof_unlocked]
!530 = metadata !{metadata !531}
!531 = metadata !{i32 786689, metadata !529, metadata !"__stream", metadata !271, i32 16777342, metadata !76, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [__stream] [line 126]
!532 = metadata !{i32 786478, metadata !1, metadata !48, metadata !"context_length_arg", metadata !"context_length_arg", metadata !"", i32 410, metadata !533, i1 true, i1 true, i32 0, i32 0, null, i32 256, i1 true, null, null, null, metadata !535, i32 411} ; [ DW_TAG_subprogram ] [line 410] [local] [def] [scope 411] [context_length_arg]
!533 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !534, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!534 = metadata !{null, metadata !183, metadata !398}
!535 = metadata !{metadata !536, metadata !537, metadata !538}
!536 = metadata !{i32 786689, metadata !532, metadata !"str", metadata !48, i32 16777626, metadata !183, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [str] [line 410]
!537 = metadata !{i32 786689, metadata !532, metadata !"out", metadata !48, i32 33554842, metadata !398, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [out] [line 410]
!538 = metadata !{i32 786688, metadata !539, metadata !"value", metadata !48, i32 412, metadata !157, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [value] [line 412]
!539 = metadata !{i32 786443, metadata !1, metadata !532} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!540 = metadata !{i32 786478, metadata !1, metadata !48, metadata !"get_nondigit_option", metadata !"get_nondigit_option", metadata !"", i32 1619, metadata !541, i1 true, i1 true, i32 0, i32 0, null, i32 256, i1 true, null, null, null, metadata !545, i32 1620} ; [ DW_TAG_subprogram ] [line 1619] [local] [def] [scope 1620] [get_nondigit_option]
!541 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !542, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!542 = metadata !{metadata !51, metadata !51, metadata !543, metadata !398}
!543 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !544} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!544 = metadata !{i32 786470, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, metadata !58} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from ]
!545 = metadata !{metadata !546, metadata !547, metadata !548, metadata !549, metadata !550, metadata !551, metadata !552, metadata !556}
!546 = metadata !{i32 786689, metadata !540, metadata !"argc", metadata !48, i32 16778835, metadata !51, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [argc] [line 1619]
!547 = metadata !{i32 786689, metadata !540, metadata !"argv", metadata !48, i32 33556051, metadata !543, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [argv] [line 1619]
!548 = metadata !{i32 786689, metadata !540, metadata !"default_context", metadata !48, i32 50333267, metadata !398, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [default_context] [line 1619]
!549 = metadata !{i32 786688, metadata !540, metadata !"opt", metadata !48, i32 1622, metadata !51, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [opt] [line 1622]
!550 = metadata !{i32 786688, metadata !540, metadata !"this_digit_optind", metadata !48, i32 1622, metadata !51, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [this_digit_optind] [line 1622]
!551 = metadata !{i32 786688, metadata !540, metadata !"was_digit", metadata !48, i32 1622, metadata !51, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [was_digit] [line 1622]
!552 = metadata !{i32 786688, metadata !540, metadata !"buf", metadata !48, i32 1623, metadata !553, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [buf] [line 1623]
!553 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 544, i64 8, i32 0, i32 0, metadata !59, metadata !554, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 544, align 8, offset 0] [from char]
!554 = metadata !{metadata !555}
!555 = metadata !{i32 786465, i64 0, i64 68}      ; [ DW_TAG_subrange_type ] [0, 67]
!556 = metadata !{i32 786688, metadata !540, metadata !"p", metadata !48, i32 1624, metadata !58, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [p] [line 1624]
!557 = metadata !{i32 786478, metadata !1, metadata !48, metadata !"setmatcher", metadata !"setmatcher", metadata !"", i32 1488, metadata !302, i1 true, i1 true, i32 0, i32 0, null, i32 256, i1 true, void (i8*)* @setmatcher, null, null, metadata !558, i32 1489} ; [ DW_TAG_subprogram ] [line 1488] [local] [def] [scope 1489] [setmatcher]
!558 = metadata !{metadata !559, metadata !560, metadata !561, metadata !567, metadata !568, metadata !573}
!559 = metadata !{i32 786689, metadata !557, metadata !"m", metadata !48, i32 16778704, metadata !183, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [m] [line 1488]
!560 = metadata !{i32 786688, metadata !557, metadata !"i", metadata !48, i32 1491, metadata !226, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 1491]
!561 = metadata !{i32 786688, metadata !562, metadata !"__s1_len", metadata !48, i32 1503, metadata !65, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__s1_len] [line 1503]
!562 = metadata !{i32 786443, metadata !1, metadata !563, i32 1503, i32 0, i32 360} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!563 = metadata !{i32 786443, metadata !1, metadata !564, i32 1503, i32 0, i32 359} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!564 = metadata !{i32 786443, metadata !1, metadata !565, i32 1502, i32 0, i32 358} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!565 = metadata !{i32 786443, metadata !1, metadata !566, i32 1501, i32 0, i32 357} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!566 = metadata !{i32 786443, metadata !1, metadata !557, i32 1493, i32 0, i32 354} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!567 = metadata !{i32 786688, metadata !562, metadata !"__s2_len", metadata !48, i32 1503, metadata !65, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__s2_len] [line 1503]
!568 = metadata !{i32 786688, metadata !569, metadata !"__s1_len", metadata !48, i32 1516, metadata !65, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__s1_len] [line 1516]
!569 = metadata !{i32 786443, metadata !1, metadata !570, i32 1516, i32 0, i32 365} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!570 = metadata !{i32 786443, metadata !1, metadata !571, i32 1516, i32 0, i32 364} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!571 = metadata !{i32 786443, metadata !1, metadata !572, i32 1515, i32 0, i32 363} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!572 = metadata !{i32 786443, metadata !1, metadata !565, i32 1514, i32 0, i32 362} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!573 = metadata !{i32 786688, metadata !569, metadata !"__s2_len", metadata !48, i32 1516, metadata !65, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__s2_len] [line 1516]
!574 = metadata !{i32 786478, metadata !1, metadata !48, metadata !"prepend_default_options", metadata !"prepend_default_options", metadata !"", i32 1596, metadata !575, i1 true, i1 true, i32 0, i32 0, null, i32 256, i1 true, null, null, null, metadata !578, i32 1597} ; [ DW_TAG_subprogram ] [line 1596] [local] [def] [scope 1597] [prepend_default_options]
!575 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !576, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!576 = metadata !{null, metadata !183, metadata !398, metadata !577}
!577 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !57} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!578 = metadata !{metadata !579, metadata !580, metadata !581, metadata !582, metadata !585, metadata !586, metadata !587, metadata !588}
!579 = metadata !{i32 786689, metadata !574, metadata !"options", metadata !48, i32 16778812, metadata !183, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [options] [line 1596]
!580 = metadata !{i32 786689, metadata !574, metadata !"pargc", metadata !48, i32 33556028, metadata !398, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [pargc] [line 1596]
!581 = metadata !{i32 786689, metadata !574, metadata !"pargv", metadata !48, i32 50333244, metadata !577, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [pargv] [line 1596]
!582 = metadata !{i32 786688, metadata !583, metadata !"buf", metadata !48, i32 1600, metadata !58, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [buf] [line 1600]
!583 = metadata !{i32 786443, metadata !1, metadata !584, i32 1599, i32 0, i32 368} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!584 = metadata !{i32 786443, metadata !1, metadata !574, i32 1598, i32 0, i32 367} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!585 = metadata !{i32 786688, metadata !583, metadata !"prepended", metadata !48, i32 1601, metadata !51, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [prepended] [line 1601]
!586 = metadata !{i32 786688, metadata !583, metadata !"argc", metadata !48, i32 1602, metadata !51, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [argc] [line 1602]
!587 = metadata !{i32 786688, metadata !583, metadata !"argv", metadata !48, i32 1603, metadata !543, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [argv] [line 1603]
!588 = metadata !{i32 786688, metadata !583, metadata !"pp", metadata !48, i32 1604, metadata !57, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [pp] [line 1604]
!589 = metadata !{i32 786478, metadata !1, metadata !48, metadata !"prepend_args", metadata !"prepend_args", metadata !"", i32 1567, metadata !590, i1 true, i1 true, i32 0, i32 0, null, i32 256, i1 true, null, null, null, metadata !592, i32 1568} ; [ DW_TAG_subprogram ] [line 1567] [local] [def] [scope 1568] [prepend_args]
!590 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !591, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!591 = metadata !{metadata !51, metadata !183, metadata !58, metadata !57}
!592 = metadata !{metadata !593, metadata !594, metadata !595, metadata !596, metadata !597, metadata !598, metadata !599, metadata !603}
!593 = metadata !{i32 786689, metadata !589, metadata !"options", metadata !48, i32 16778783, metadata !183, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [options] [line 1567]
!594 = metadata !{i32 786689, metadata !589, metadata !"buf", metadata !48, i32 33555999, metadata !58, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [buf] [line 1567]
!595 = metadata !{i32 786689, metadata !589, metadata !"argv", metadata !48, i32 50333215, metadata !57, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [argv] [line 1567]
!596 = metadata !{i32 786688, metadata !589, metadata !"o", metadata !48, i32 1569, metadata !183, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [o] [line 1569]
!597 = metadata !{i32 786688, metadata !589, metadata !"b", metadata !48, i32 1570, metadata !58, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [b] [line 1570]
!598 = metadata !{i32 786688, metadata !589, metadata !"n", metadata !48, i32 1571, metadata !51, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [n] [line 1571]
!599 = metadata !{i32 786688, metadata !600, metadata !"__c", metadata !48, i32 1575, metadata !51, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__c] [line 1575]
!600 = metadata !{i32 786443, metadata !1, metadata !601, i32 1575, i32 0, i32 371} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!601 = metadata !{i32 786443, metadata !1, metadata !602, i32 1574, i32 0, i32 370} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!602 = metadata !{i32 786443, metadata !1, metadata !589, i32 1573, i32 0, i32 369} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!603 = metadata !{i32 786688, metadata !604, metadata !"__c", metadata !48, i32 1586, metadata !51, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__c] [line 1586]
!604 = metadata !{i32 786443, metadata !1, metadata !601, i32 1586, i32 0, i32 375} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!605 = metadata !{metadata !606, metadata !607, metadata !608, metadata !609, metadata !610, metadata !611, metadata !612, metadata !613, metadata !617, metadata !618, metadata !619, metadata !620, metadata !621, metadata !622, metadata !623, metadata !624, metadata !630, metadata !631, metadata !632, metadata !633, metadata !634, metadata !635, metadata !636, metadata !637, metadata !638, metadata !639, metadata !640, metadata !641, metadata !642, metadata !643, metadata !644, metadata !645, metadata !646, metadata !647, metadata !648, metadata !649, metadata !650, metadata !651, metadata !652, metadata !653, metadata !654, metadata !655, metadata !656, metadata !657, metadata !660, metadata !661, metadata !662, metadata !663, metadata !664, metadata !665, metadata !666, metadata !667, metadata !668, metadata !669, metadata !670, metadata !671, metadata !672, metadata !673, metadata !677, metadata !678, metadata !679, metadata !680, metadata !681, metadata !682, metadata !685, metadata !690, metadata !691, metadata !692, metadata !704, metadata !708}
!606 = metadata !{i32 786484, i32 0, null, metadata !"stats_base", metadata !"stats_base", metadata !"", metadata !48, i32 69, metadata !209, i32 1, i32 1, %struct.stats* @stats_base, null} ; [ DW_TAG_variable ] [stats_base] [line 69] [local] [def]
!607 = metadata !{i32 786484, i32 0, null, metadata !"show_help", metadata !"show_help", metadata !"", metadata !48, i32 72, metadata !51, i32 1, i32 1, i32* @show_help, null} ; [ DW_TAG_variable ] [show_help] [line 72] [local] [def]
!608 = metadata !{i32 786484, i32 0, null, metadata !"show_version", metadata !"show_version", metadata !"", metadata !48, i32 75, metadata !51, i32 1, i32 1, null, null} ; [ DW_TAG_variable ] [show_version] [line 75] [local] [def]
!609 = metadata !{i32 786484, i32 0, null, metadata !"suppress_errors", metadata !"suppress_errors", metadata !"", metadata !48, i32 78, metadata !51, i32 1, i32 1, null, null} ; [ DW_TAG_variable ] [suppress_errors] [line 78] [local] [def]
!610 = metadata !{i32 786484, i32 0, null, metadata !"color_option", metadata !"color_option", metadata !"", metadata !48, i32 81, metadata !51, i32 1, i32 1, i32* @color_option, null} ; [ DW_TAG_variable ] [color_option] [line 81] [local] [def]
!611 = metadata !{i32 786484, i32 0, null, metadata !"only_matching", metadata !"only_matching", metadata !"", metadata !48, i32 84, metadata !51, i32 1, i32 1, null, null} ; [ DW_TAG_variable ] [only_matching] [line 84] [local] [def]
!612 = metadata !{i32 786484, i32 0, null, metadata !"align_tabs", metadata !"align_tabs", metadata !"", metadata !48, i32 87, metadata !51, i32 1, i32 1, null, null} ; [ DW_TAG_variable ] [align_tabs] [line 87] [local] [def]
!613 = metadata !{i32 786484, i32 0, null, metadata !"excluded_patterns", metadata !"excluded_patterns", metadata !"", metadata !48, i32 270, metadata !614, i32 1, i32 1, %struct.exclude** @excluded_patterns, null} ; [ DW_TAG_variable ] [excluded_patterns] [line 270] [local] [def]
!614 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !615} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from exclude]
!615 = metadata !{i32 786451, metadata !616, null, metadata !"exclude", i32 40, i64 0, i64 0, i32 0, i32 4, null, null, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [exclude] [line 40, size 0, align 0, offset 0] [decl] [from ]
!616 = metadata !{metadata !"../lib/exclude.h", metadata !"/home/kostas/workspace/test/grep-2.7/src"}
!617 = metadata !{i32 786484, i32 0, null, metadata !"included_patterns", metadata !"included_patterns", metadata !"", metadata !48, i32 271, metadata !614, i32 1, i32 1, %struct.exclude** @included_patterns, null} ; [ DW_TAG_variable ] [included_patterns] [line 271] [local] [def]
!618 = metadata !{i32 786484, i32 0, null, metadata !"excluded_directory_patterns", metadata !"excluded_directory_patterns", metadata !"", metadata !48, i32 272, metadata !614, i32 1, i32 1, %struct.exclude** @excluded_directory_patterns, null} ; [ DW_TAG_variable ] [excluded_directory_patterns] [line 272] [local] [def]
!619 = metadata !{i32 786484, i32 0, null, metadata !"match_icase", metadata !"match_icase", metadata !"", metadata !48, i32 351, metadata !51, i32 0, i32 1, i32* @match_icase, null} ; [ DW_TAG_variable ] [match_icase] [line 351] [def]
!620 = metadata !{i32 786484, i32 0, null, metadata !"match_words", metadata !"match_words", metadata !"", metadata !48, i32 352, metadata !51, i32 0, i32 1, i32* @match_words, null} ; [ DW_TAG_variable ] [match_words] [line 352] [def]
!621 = metadata !{i32 786484, i32 0, null, metadata !"match_lines", metadata !"match_lines", metadata !"", metadata !48, i32 353, metadata !51, i32 0, i32 1, i32* @match_lines, null} ; [ DW_TAG_variable ] [match_lines] [line 353] [def]
!622 = metadata !{i32 786484, i32 0, null, metadata !"eolbyte", metadata !"eolbyte", metadata !"", metadata !48, i32 354, metadata !140, i32 0, i32 1, i8* @eolbyte, null} ; [ DW_TAG_variable ] [eolbyte] [line 354] [def]
!623 = metadata !{i32 786484, i32 0, null, metadata !"errseen", metadata !"errseen", metadata !"", metadata !48, i32 359, metadata !51, i32 1, i32 1, null, null} ; [ DW_TAG_variable ] [errseen] [line 359] [local] [def]
!624 = metadata !{i32 786484, i32 0, null, metadata !"compile", metadata !"compile", metadata !"", metadata !48, i32 394, metadata !625, i32 1, i32 1, void (i8*, i64)** @compile, null} ; [ DW_TAG_variable ] [compile] [line 394] [local] [def]
!625 = metadata !{i32 786454, metadata !626, null, metadata !"compile_fp_t", i32 25, i64 0, i64 0, i64 0, i32 0, metadata !627} ; [ DW_TAG_typedef ] [compile_fp_t] [line 25, size 0, align 0, offset 0] [from ]
!626 = metadata !{metadata !"./grep.h", metadata !"/home/kostas/workspace/test/grep-2.7/src"}
!627 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !628} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!628 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !629, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!629 = metadata !{null, metadata !183, metadata !65}
!630 = metadata !{i32 786484, i32 0, null, metadata !"binary_files", metadata !"binary_files", metadata !"", metadata !48, i32 576, metadata !27, i32 1, i32 1, i32* @binary_files, null} ; [ DW_TAG_variable ] [binary_files] [line 576] [local] [def]
!631 = metadata !{i32 786484, i32 0, null, metadata !"filename_mask", metadata !"filename_mask", metadata !"", metadata !48, i32 578, metadata !51, i32 1, i32 1, null, null} ; [ DW_TAG_variable ] [filename_mask] [line 578] [local] [def]
!632 = metadata !{i32 786484, i32 0, null, metadata !"out_quiet", metadata !"out_quiet", metadata !"", metadata !48, i32 579, metadata !51, i32 1, i32 1, i32* @out_quiet, null} ; [ DW_TAG_variable ] [out_quiet] [line 579] [local] [def]
!633 = metadata !{i32 786484, i32 0, null, metadata !"out_invert", metadata !"out_invert", metadata !"", metadata !48, i32 580, metadata !51, i32 1, i32 1, i32* @out_invert, null} ; [ DW_TAG_variable ] [out_invert] [line 580] [local] [def]
!634 = metadata !{i32 786484, i32 0, null, metadata !"out_file", metadata !"out_file", metadata !"", metadata !48, i32 581, metadata !51, i32 1, i32 1, i32* @out_file, null} ; [ DW_TAG_variable ] [out_file] [line 581] [local] [def]
!635 = metadata !{i32 786484, i32 0, null, metadata !"out_line", metadata !"out_line", metadata !"", metadata !48, i32 582, metadata !51, i32 1, i32 1, null, null} ; [ DW_TAG_variable ] [out_line] [line 582] [local] [def]
!636 = metadata !{i32 786484, i32 0, null, metadata !"out_byte", metadata !"out_byte", metadata !"", metadata !48, i32 583, metadata !51, i32 1, i32 1, null, null} ; [ DW_TAG_variable ] [out_byte] [line 583] [local] [def]
!637 = metadata !{i32 786484, i32 0, null, metadata !"out_before", metadata !"out_before", metadata !"", metadata !48, i32 584, metadata !51, i32 1, i32 1, i32* @out_before, null} ; [ DW_TAG_variable ] [out_before] [line 584] [local] [def]
!638 = metadata !{i32 786484, i32 0, null, metadata !"out_after", metadata !"out_after", metadata !"", metadata !48, i32 585, metadata !51, i32 1, i32 1, i32* @out_after, null} ; [ DW_TAG_variable ] [out_after] [line 585] [local] [def]
!639 = metadata !{i32 786484, i32 0, null, metadata !"count_matches", metadata !"count_matches", metadata !"", metadata !48, i32 586, metadata !51, i32 1, i32 1, null, null} ; [ DW_TAG_variable ] [count_matches] [line 586] [local] [def]
!640 = metadata !{i32 786484, i32 0, null, metadata !"list_files", metadata !"list_files", metadata !"", metadata !48, i32 587, metadata !51, i32 1, i32 1, i32* @list_files, null} ; [ DW_TAG_variable ] [list_files] [line 587] [local] [def]
!641 = metadata !{i32 786484, i32 0, null, metadata !"no_filenames", metadata !"no_filenames", metadata !"", metadata !48, i32 588, metadata !51, i32 1, i32 1, null, null} ; [ DW_TAG_variable ] [no_filenames] [line 588] [local] [def]
!642 = metadata !{i32 786484, i32 0, null, metadata !"max_count", metadata !"max_count", metadata !"", metadata !48, i32 589, metadata !267, i32 1, i32 1, i64* @max_count, null} ; [ DW_TAG_variable ] [max_count] [line 589] [local] [def]
!643 = metadata !{i32 786484, i32 0, null, metadata !"line_buffered", metadata !"line_buffered", metadata !"", metadata !48, i32 591, metadata !51, i32 1, i32 1, null, null} ; [ DW_TAG_variable ] [line_buffered] [line 591] [local] [def]
!644 = metadata !{i32 786484, i32 0, null, metadata !"done_on_match", metadata !"done_on_match", metadata !"", metadata !48, i32 606, metadata !51, i32 1, i32 1, i32* @done_on_match, null} ; [ DW_TAG_variable ] [done_on_match] [line 606] [local] [def]
!645 = metadata !{i32 786484, i32 0, null, metadata !"exit_on_match", metadata !"exit_on_match", metadata !"", metadata !48, i32 607, metadata !51, i32 1, i32 1, null, null} ; [ DW_TAG_variable ] [exit_on_match] [line 607] [local] [def]
!646 = metadata !{i32 786484, i32 0, null, metadata !"after_last_match", metadata !"after_last_match", metadata !"", metadata !48, i32 435, metadata !267, i32 1, i32 1, i64* @after_last_match, null} ; [ DW_TAG_variable ] [after_last_match] [line 435] [local] [def]
!647 = metadata !{i32 786484, i32 0, null, metadata !"bufoffset", metadata !"bufoffset", metadata !"", metadata !48, i32 434, metadata !267, i32 1, i32 1, i64* @bufoffset, null} ; [ DW_TAG_variable ] [bufoffset] [line 434] [local] [def]
!648 = metadata !{i32 786484, i32 0, null, metadata !"outleft", metadata !"outleft", metadata !"", metadata !48, i32 603, metadata !267, i32 1, i32 1, i64* @outleft, null} ; [ DW_TAG_variable ] [outleft] [line 603] [local] [def]
!649 = metadata !{i32 786484, i32 0, null, metadata !"sgr_end", metadata !"sgr_end", metadata !"", metadata !48, i32 207, metadata !183, i32 1, i32 1, i8** @sgr_end, null} ; [ DW_TAG_variable ] [sgr_end] [line 207] [local] [def]
!650 = metadata !{i32 786484, i32 0, null, metadata !"sgr_start", metadata !"sgr_start", metadata !"", metadata !48, i32 205, metadata !183, i32 1, i32 1, i8** @sgr_start, null} ; [ DW_TAG_variable ] [sgr_start] [line 205] [local] [def]
!651 = metadata !{i32 786484, i32 0, null, metadata !"sep_color", metadata !"sep_color", metadata !"", metadata !48, i32 144, metadata !183, i32 1, i32 1, i8** @sep_color, null} ; [ DW_TAG_variable ] [sep_color] [line 144] [local] [def]
!652 = metadata !{i32 786484, i32 0, null, metadata !"filename_color", metadata !"filename_color", metadata !"", metadata !48, i32 141, metadata !183, i32 1, i32 1, i8** @filename_color, null} ; [ DW_TAG_variable ] [filename_color] [line 141] [local] [def]
!653 = metadata !{i32 786484, i32 0, null, metadata !"context_line_color", metadata !"context_line_color", metadata !"", metadata !48, i32 146, metadata !183, i32 1, i32 1, i8** @context_line_color, null} ; [ DW_TAG_variable ] [context_line_color] [line 146] [local] [def]
!654 = metadata !{i32 786484, i32 0, null, metadata !"selected_line_color", metadata !"selected_line_color", metadata !"", metadata !48, i32 145, metadata !183, i32 1, i32 1, i8** @selected_line_color, null} ; [ DW_TAG_variable ] [selected_line_color] [line 145] [local] [def]
!655 = metadata !{i32 786484, i32 0, null, metadata !"byte_num_color", metadata !"byte_num_color", metadata !"", metadata !48, i32 143, metadata !183, i32 1, i32 1, i8** @byte_num_color, null} ; [ DW_TAG_variable ] [byte_num_color] [line 143] [local] [def]
!656 = metadata !{i32 786484, i32 0, null, metadata !"line_num_color", metadata !"line_num_color", metadata !"", metadata !48, i32 142, metadata !183, i32 1, i32 1, i8** @line_num_color, null} ; [ DW_TAG_variable ] [line_num_color] [line 142] [local] [def]
!657 = metadata !{i32 786484, i32 0, null, metadata !"execute", metadata !"execute", metadata !"", metadata !48, i32 395, metadata !658, i32 1, i32 1, i64 (i8*, i64, i64*, i8*)** @execute, null} ; [ DW_TAG_variable ] [execute] [line 395] [local] [def]
!658 = metadata !{i32 786454, metadata !626, null, metadata !"execute_fp_t", i32 26, i64 0, i64 0, i64 0, i32 0, metadata !659} ; [ DW_TAG_typedef ] [execute_fp_t] [line 26, size 0, align 0, offset 0] [from ]
!659 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !418} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!660 = metadata !{i32 786484, i32 0, metadata !395, metadata !"used", metadata !"used", metadata !"", metadata !48, i32 897, metadata !51, i32 1, i32 1, null, null} ; [ DW_TAG_variable ] [used] [line 897] [local] [def]
!661 = metadata !{i32 786484, i32 0, null, metadata !"lastnl", metadata !"lastnl", metadata !"", metadata !48, i32 598, metadata !183, i32 1, i32 1, i8** @lastnl, null} ; [ DW_TAG_variable ] [lastnl] [line 598] [local] [def]
!662 = metadata !{i32 786484, i32 0, null, metadata !"buflim", metadata !"buflim", metadata !"", metadata !48, i32 432, metadata !58, i32 1, i32 1, i8** @buflim, null} ; [ DW_TAG_variable ] [buflim] [line 432] [local] [def]
!663 = metadata !{i32 786484, i32 0, null, metadata !"bufbeg", metadata !"bufbeg", metadata !"", metadata !48, i32 431, metadata !58, i32 1, i32 1, i8** @bufbeg, null} ; [ DW_TAG_variable ] [bufbeg] [line 431] [local] [def]
!664 = metadata !{i32 786484, i32 0, null, metadata !"bufdesc", metadata !"bufdesc", metadata !"", metadata !48, i32 430, metadata !51, i32 1, i32 1, i32* @bufdesc, null} ; [ DW_TAG_variable ] [bufdesc] [line 430] [local] [def]
!665 = metadata !{i32 786484, i32 0, null, metadata !"bufalloc", metadata !"bufalloc", metadata !"", metadata !48, i32 428, metadata !65, i32 1, i32 1, i64* @bufalloc, null} ; [ DW_TAG_variable ] [bufalloc] [line 428] [local] [def]
!666 = metadata !{i32 786484, i32 0, null, metadata !"pagesize", metadata !"pagesize", metadata !"", metadata !48, i32 433, metadata !65, i32 1, i32 1, i64* @pagesize, null} ; [ DW_TAG_variable ] [pagesize] [line 433] [local] [def]
!667 = metadata !{i32 786484, i32 0, null, metadata !"buffer", metadata !"buffer", metadata !"", metadata !48, i32 427, metadata !58, i32 1, i32 1, i8** @buffer, null} ; [ DW_TAG_variable ] [buffer] [line 427] [local] [def]
!668 = metadata !{i32 786484, i32 0, null, metadata !"pending", metadata !"pending", metadata !"", metadata !48, i32 604, metadata !51, i32 1, i32 1, i32* @pending, null} ; [ DW_TAG_variable ] [pending] [line 604] [local] [def]
!669 = metadata !{i32 786484, i32 0, null, metadata !"totalnl", metadata !"totalnl", metadata !"", metadata !48, i32 602, metadata !157, i32 1, i32 1, i64* @totalnl, null} ; [ DW_TAG_variable ] [totalnl] [line 602] [local] [def]
!670 = metadata !{i32 786484, i32 0, null, metadata !"lastout", metadata !"lastout", metadata !"", metadata !48, i32 599, metadata !183, i32 1, i32 1, i8** @lastout, null} ; [ DW_TAG_variable ] [lastout] [line 599] [local] [def]
!671 = metadata !{i32 786484, i32 0, null, metadata !"totalcc", metadata !"totalcc", metadata !"", metadata !48, i32 597, metadata !157, i32 1, i32 1, i64* @totalcc, null} ; [ DW_TAG_variable ] [totalcc] [line 597] [local] [def]
!672 = metadata !{i32 786484, i32 0, null, metadata !"filename", metadata !"filename", metadata !"", metadata !48, i32 358, metadata !183, i32 1, i32 1, i8** @filename, null} ; [ DW_TAG_variable ] [filename] [line 358] [local] [def]
!673 = metadata !{i32 786484, i32 0, null, metadata !"color_dict", metadata !"color_dict", metadata !"", metadata !48, i32 254, metadata !674, i32 1, i32 1, [12 x %struct.color_cap]* @color_dict, null} ; [ DW_TAG_variable ] [color_dict] [line 254] [local] [def]
!674 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 2304, i64 64, i32 0, i32 0, metadata !509, metadata !675, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 2304, align 64, offset 0] [from color_cap]
!675 = metadata !{metadata !676}
!676 = metadata !{i32 786465, i64 0, i64 12}      ; [ DW_TAG_subrange_type ] [0, 11]
!677 = metadata !{i32 786484, i32 0, null, metadata !"selected_match_color", metadata !"selected_match_color", metadata !"", metadata !48, i32 137, metadata !183, i32 1, i32 1, i8** @selected_match_color, null} ; [ DW_TAG_variable ] [selected_match_color] [line 137] [local] [def]
!678 = metadata !{i32 786484, i32 0, null, metadata !"context_match_color", metadata !"context_match_color", metadata !"", metadata !48, i32 138, metadata !183, i32 1, i32 1, i8** @context_match_color, null} ; [ DW_TAG_variable ] [context_match_color] [line 138] [local] [def]
!679 = metadata !{i32 786484, i32 0, null, metadata !"label", metadata !"label", metadata !"", metadata !48, i32 593, metadata !58, i32 1, i32 1, i8** @label, null} ; [ DW_TAG_variable ] [label] [line 593] [local] [def]
!680 = metadata !{i32 786484, i32 0, null, metadata !"group_separator", metadata !"group_separator", metadata !"", metadata !48, i32 90, metadata !183, i32 1, i32 1, i8** @group_separator, null} ; [ DW_TAG_variable ] [group_separator] [line 90] [local] [def]
!681 = metadata !{i32 786484, i32 0, null, metadata !"directories", metadata !"directories", metadata !"", metadata !48, i32 379, metadata !32, i32 1, i32 1, i32* @directories, null} ; [ DW_TAG_variable ] [directories] [line 379] [local] [def]
!682 = metadata !{i32 786484, i32 0, null, metadata !"directories_types", metadata !"directories_types", metadata !"", metadata !48, i32 373, metadata !683, i32 1, i32 1, [3 x i32]* @directories_types, null} ; [ DW_TAG_variable ] [directories_types] [line 373] [local] [def]
!683 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 96, i64 32, i32 0, i32 0, metadata !684, metadata !249, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 96, align 32, offset 0] [from ]
!684 = metadata !{i32 786470, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, metadata !32} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from directories_type]
!685 = metadata !{i32 786484, i32 0, null, metadata !"directories_args", metadata !"directories_args", metadata !"", metadata !48, i32 369, metadata !686, i32 1, i32 1, [4 x i8*]* @directories_args, null} ; [ DW_TAG_variable ] [directories_args] [line 369] [local] [def]
!686 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 256, i64 64, i32 0, i32 0, metadata !687, metadata !688, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 256, align 64, offset 0] [from ]
!687 = metadata !{i32 786470, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, metadata !183} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from ]
!688 = metadata !{metadata !689}
!689 = metadata !{i32 786465, i64 0, i64 4}       ; [ DW_TAG_subrange_type ] [0, 3]
!690 = metadata !{i32 786484, i32 0, null, metadata !"devices", metadata !"devices", metadata !"", metadata !48, i32 386, metadata !23, i32 1, i32 1, null, null} ; [ DW_TAG_variable ] [devices] [line 386] [local] [def]
!691 = metadata !{i32 786484, i32 0, metadata !540, metadata !"prev_digit_optind", metadata !"prev_digit_optind", metadata !"", metadata !48, i32 1621, metadata !51, i32 1, i32 1, i32* @get_nondigit_option.prev_digit_optind, null} ; [ DW_TAG_variable ] [prev_digit_optind] [line 1621] [local] [def]
!692 = metadata !{i32 786484, i32 0, null, metadata !"long_options", metadata !"long_options", metadata !"", metadata !48, i32 293, metadata !693, i32 1, i32 1, <{ { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] } }>* @long_options, null} ; [ DW_TAG_variable ] [long_options] [line 293] [local] [def]
!693 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 13056, i64 64, i32 0, i32 0, metadata !694, metadata !702, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 13056, align 64, offset 0] [from ]
!694 = metadata !{i32 786470, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, metadata !695} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from option]
!695 = metadata !{i32 786451, metadata !696, null, metadata !"option", i32 106, i64 256, i64 64, i32 0, i32 0, null, metadata !697, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [option] [line 106, size 256, align 64, offset 0] [def] [from ]
!696 = metadata !{metadata !"/usr/include/getopt.h", metadata !"/home/kostas/workspace/test/grep-2.7/src"}
!697 = metadata !{metadata !698, metadata !699, metadata !700, metadata !701}
!698 = metadata !{i32 786445, metadata !696, metadata !695, metadata !"name", i32 108, i64 64, i64 64, i64 0, i32 0, metadata !183} ; [ DW_TAG_member ] [name] [line 108, size 64, align 64, offset 0] [from ]
!699 = metadata !{i32 786445, metadata !696, metadata !695, metadata !"has_arg", i32 111, i64 32, i64 32, i64 64, i32 0, metadata !51} ; [ DW_TAG_member ] [has_arg] [line 111, size 32, align 32, offset 64] [from int]
!700 = metadata !{i32 786445, metadata !696, metadata !695, metadata !"flag", i32 112, i64 64, i64 64, i64 128, i32 0, metadata !398} ; [ DW_TAG_member ] [flag] [line 112, size 64, align 64, offset 128] [from ]
!701 = metadata !{i32 786445, metadata !696, metadata !695, metadata !"val", i32 113, i64 32, i64 32, i64 192, i32 0, metadata !51} ; [ DW_TAG_member ] [val] [line 113, size 32, align 32, offset 192] [from int]
!702 = metadata !{metadata !703}
!703 = metadata !{i32 786465, i64 0, i64 51}      ; [ DW_TAG_subrange_type ] [0, 50]
!704 = metadata !{i32 786484, i32 0, null, metadata !"short_options", metadata !"short_options", metadata !"", metadata !48, i32 274, metadata !705, i32 1, i32 1, [59 x i8]* @short_options, null} ; [ DW_TAG_variable ] [short_options] [line 274] [local] [def]
!705 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 472, i64 8, i32 0, i32 0, metadata !184, metadata !706, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 472, align 8, offset 0] [from ]
!706 = metadata !{metadata !707}
!707 = metadata !{i32 786465, i64 0, i64 59}      ; [ DW_TAG_subrange_type ] [0, 58]
!708 = metadata !{i32 786484, i32 0, metadata !557, metadata !"matcher", metadata !"matcher", metadata !"", metadata !48, i32 1490, metadata !183, i32 1, i32 1, i8** @setmatcher.matcher, null} ; [ DW_TAG_variable ] [matcher] [line 1490] [local] [def]
!709 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!710 = metadata !{i32 1, metadata !"Debug Info Version", i32 1}
!711 = metadata !{metadata !"clang version 3.5 (http://llvm.org/git/clang.git 9ac60551645be7a3c5f9b702159052f2f1a5b26a) (http://llvm.org/git/llvm.git 5e7eecd8509707a77a6b84c7879b947e14698ef0)"}
!712 = metadata !{i32 1375, i32 0, metadata !47, null}
!713 = metadata !{i32 1377, i32 0, metadata !714, null}
!714 = metadata !{i32 786443, metadata !1, metadata !47, i32 1377, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!715 = metadata !{i32 1379, i32 0, metadata !716, null}
!716 = metadata !{i32 786443, metadata !1, metadata !714, i32 1378, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!717 = metadata !{metadata !718, metadata !718, i64 0}
!718 = metadata !{metadata !"any pointer", metadata !719, i64 0}
!719 = metadata !{metadata !"omnipotent char", metadata !720, i64 0}
!720 = metadata !{metadata !"Simple C/C++ TBAA"}
!721 = metadata !{i32 1381, i32 0, metadata !716, null}
!722 = metadata !{i32 1383, i32 0, metadata !716, null}
!723 = metadata !{i32 1386, i32 0, metadata !724, null}
!724 = metadata !{i32 786443, metadata !1, metadata !714, i32 1385, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!725 = metadata !{i32 1387, i32 0, metadata !724, null}
!726 = metadata !{i32 1389, i32 0, metadata !724, null}
!727 = metadata !{i32 1390, i32 0, metadata !724, null}
!728 = metadata !{i32 1394, i32 0, metadata !729, null}
!729 = metadata !{i32 786443, metadata !1, metadata !724, i32 1394, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!730 = metadata !{metadata !731, metadata !718, i64 0}
!731 = metadata !{metadata !"matcher", metadata !718, i64 0, metadata !718, i64 8, metadata !718, i64 16}
!732 = metadata !{i32 1395, i32 0, metadata !729, null}
!733 = metadata !{i32 1401, i32 0, metadata !724, null}
!734 = metadata !{i32 1408, i32 0, metadata !724, null}
!735 = metadata !{i32 1416, i32 0, metadata !724, null}
!736 = metadata !{i32 1427, i32 0, metadata !724, null}
!737 = metadata !{i32 1434, i32 0, metadata !724, null}
!738 = metadata !{i32 1442, i32 0, metadata !724, null}
!739 = metadata !{i32 1448, i32 0, metadata !724, null}
!740 = metadata !{i32 1454, i32 0, metadata !724, null}
!741 = metadata !{i32 1461, i32 0, metadata !724, null}
!742 = metadata !{i32 1469, i32 0, metadata !724, null}
!743 = metadata !{i32 1470, i32 0, metadata !724, null}
!744 = metadata !{i32 1474, i32 0, metadata !724, null}
!745 = metadata !{i32 1475, i32 0, metadata !724, null}
!746 = metadata !{i32 1477, i32 0, metadata !724, null}
!747 = metadata !{i32 1481, i32 0, metadata !47, null}
!748 = metadata !{i32 1754, i32 0, metadata !54, null}
!749 = metadata !{i32 786689, metadata !574, metadata !"pargc", metadata !48, i32 33556028, metadata !398, i32 0, metadata !750} ; [ DW_TAG_arg_variable ] [pargc] [line 1596]
!750 = metadata !{i32 1794, i32 0, metadata !54, null}
!751 = metadata !{i32 1596, i32 0, metadata !574, metadata !750}
!752 = metadata !{i32 1797, i32 0, metadata !54, null}
!753 = metadata !{i32 2139, i32 0, metadata !754, null}
!754 = metadata !{i32 786443, metadata !1, metadata !755, i32 2139, i32 0, i32 97} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!755 = metadata !{i32 786443, metadata !1, metadata !54, i32 2126, i32 0, i32 93} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!756 = metadata !{i32 2153, i32 0, metadata !757, null}
!757 = metadata !{i32 786443, metadata !1, metadata !54, i32 2153, i32 0, i32 99} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!758 = metadata !{i32 2166, i32 0, metadata !198, null}
!759 = metadata !{i32 2184, i32 0, metadata !196, null}
!760 = metadata !{i32 786689, metadata !574, metadata !"pargv", metadata !48, i32 50333244, metadata !577, i32 0, metadata !750} ; [ DW_TAG_arg_variable ] [pargv] [line 1596]
!761 = metadata !{i32 1765, i32 0, metadata !54, null}
!762 = metadata !{i32 2142, i32 0, metadata !763, null}
!763 = metadata !{i32 786443, metadata !1, metadata !754, i32 2140, i32 0, i32 98} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!764 = metadata !{i32 2144, i32 0, metadata !763, null}
!765 = metadata !{i32 2171, i32 0, metadata !196, null}
!766 = metadata !{i32 1764, i32 0, metadata !54, null}
!767 = metadata !{i8* null}
!768 = metadata !{i32 1767, i32 0, metadata !54, null}
!769 = metadata !{i64 0}
!770 = metadata !{i32 1768, i32 0, metadata !54, null}
!771 = metadata !{i32 1769, i32 0, metadata !54, null}
!772 = metadata !{i32 1770, i32 0, metadata !54, null}
!773 = metadata !{metadata !719, metadata !719, i64 0}
!774 = metadata !{i32 1773, i32 0, metadata !54, null}
!775 = metadata !{metadata !776, metadata !776, i64 0}
!776 = metadata !{metadata !"long", metadata !719, i64 0}
!777 = metadata !{i32 1776, i32 0, metadata !54, null}
!778 = metadata !{metadata !779, metadata !779, i64 0}
!779 = metadata !{metadata !"int", metadata !719, i64 0}
!780 = metadata !{i32 1778, i32 0, metadata !54, null}
!781 = metadata !{i32 786689, metadata !532, metadata !"out", metadata !48, i32 33554842, metadata !398, i32 0, metadata !782} ; [ DW_TAG_arg_variable ] [out] [line 410]
!782 = metadata !{i32 1811, i32 0, metadata !134, null}
!783 = metadata !{i32 410, i32 0, metadata !532, metadata !782}
!784 = metadata !{i32 786689, metadata !532, metadata !"out", metadata !48, i32 33554842, metadata !398, i32 0, metadata !785} ; [ DW_TAG_arg_variable ] [out] [line 410]
!785 = metadata !{i32 1662, i32 0, metadata !786, metadata !752}
!786 = metadata !{i32 786443, metadata !1, metadata !787, i32 1660, i32 0, i32 353} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!787 = metadata !{i32 786443, metadata !1, metadata !540, i32 1659, i32 0, i32 352} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!788 = metadata !{i32 410, i32 0, metadata !532, metadata !785}
!789 = metadata !{i32 786689, metadata !540, metadata !"default_context", metadata !48, i32 50333267, metadata !398, i32 0, metadata !752} ; [ DW_TAG_arg_variable ] [default_context] [line 1619]
!790 = metadata !{i32 1619, i32 0, metadata !540, metadata !752}
!791 = metadata !{i32 2101, i32 0, metadata !792, null}
!792 = metadata !{i32 786443, metadata !1, metadata !54, i32 2100, i32 0, i32 85} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!793 = metadata !{i32 2103, i32 0, metadata !794, null}
!794 = metadata !{i32 786443, metadata !1, metadata !54, i32 2102, i32 0, i32 86} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!795 = metadata !{i32 1784, i32 0, metadata !54, null}
!796 = metadata !{i32 1787, i32 0, metadata !54, null}
!797 = metadata !{i32 1788, i32 0, metadata !54, null}
!798 = metadata !{i32 1791, i32 0, metadata !54, null}
!799 = metadata !{i32 1792, i32 0, metadata !54, null}
!800 = metadata !{i32 786689, metadata !574, metadata !"options", metadata !48, i32 16778812, metadata !183, i32 0, metadata !750} ; [ DW_TAG_arg_variable ] [options] [line 1596]
!801 = metadata !{i32 1598, i32 0, metadata !584, metadata !750}
!802 = metadata !{i32 1600, i32 0, metadata !583, metadata !750}
!803 = metadata !{i32 786688, metadata !583, metadata !"buf", metadata !48, i32 1600, metadata !58, i32 0, metadata !750} ; [ DW_TAG_auto_variable ] [buf] [line 1600]
!804 = metadata !{i32 786689, metadata !589, metadata !"options", metadata !48, i32 16778783, metadata !183, i32 0, metadata !805} ; [ DW_TAG_arg_variable ] [options] [line 1567]
!805 = metadata !{i32 1601, i32 0, metadata !583, metadata !750}
!806 = metadata !{i32 1567, i32 0, metadata !589, metadata !805}
!807 = metadata !{i32 786689, metadata !589, metadata !"buf", metadata !48, i32 33555999, metadata !58, i32 0, metadata !805} ; [ DW_TAG_arg_variable ] [buf] [line 1567]
!808 = metadata !{i8** null}
!809 = metadata !{i32 786689, metadata !589, metadata !"argv", metadata !48, i32 50333215, metadata !57, i32 0, metadata !805} ; [ DW_TAG_arg_variable ] [argv] [line 1567]
!810 = metadata !{i32 786688, metadata !589, metadata !"o", metadata !48, i32 1569, metadata !183, i32 0, metadata !805} ; [ DW_TAG_auto_variable ] [o] [line 1569]
!811 = metadata !{i32 1569, i32 0, metadata !589, metadata !805}
!812 = metadata !{i32 786688, metadata !589, metadata !"b", metadata !48, i32 1570, metadata !58, i32 0, metadata !805} ; [ DW_TAG_auto_variable ] [b] [line 1570]
!813 = metadata !{i32 1570, i32 0, metadata !589, metadata !805}
!814 = metadata !{i32 786688, metadata !589, metadata !"n", metadata !48, i32 1571, metadata !51, i32 0, metadata !805} ; [ DW_TAG_auto_variable ] [n] [line 1571]
!815 = metadata !{i32 1571, i32 0, metadata !589, metadata !805}
!816 = metadata !{i32 1573, i32 0, metadata !602, metadata !805}
!817 = metadata !{i32 1575, i32 0, metadata !600, metadata !805}
!818 = metadata !{i32 1576, i32 0, metadata !601, metadata !805}
!819 = metadata !{i32 1589, i32 0, metadata !601, metadata !805}
!820 = metadata !{i32 1583, i32 0, metadata !601, metadata !805}
!821 = metadata !{i32 1584, i32 0, metadata !822, metadata !805}
!822 = metadata !{i32 786443, metadata !1, metadata !601, i32 1584, i32 0, i32 374} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!823 = metadata !{i32 1585, i32 0, metadata !822, metadata !805}
!824 = metadata !{i32 1588, i32 0, metadata !601, metadata !805}
!825 = metadata !{i32 1578, i32 0, metadata !826, metadata !805}
!826 = metadata !{i32 786443, metadata !1, metadata !601, i32 1577, i32 0, i32 372} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!827 = metadata !{i32 786688, metadata !583, metadata !"prepended", metadata !48, i32 1601, metadata !51, i32 0, metadata !750} ; [ DW_TAG_auto_variable ] [prepended] [line 1601]
!828 = metadata !{i32 786688, metadata !583, metadata !"argc", metadata !48, i32 1602, metadata !51, i32 0, metadata !750} ; [ DW_TAG_auto_variable ] [argc] [line 1602]
!829 = metadata !{i32 1602, i32 0, metadata !583, metadata !750}
!830 = metadata !{i32 786688, metadata !583, metadata !"argv", metadata !48, i32 1603, metadata !543, i32 0, metadata !750} ; [ DW_TAG_auto_variable ] [argv] [line 1603]
!831 = metadata !{i32 1603, i32 0, metadata !583, metadata !750}
!832 = metadata !{i32 1604, i32 0, metadata !583, metadata !750}
!833 = metadata !{i32 786688, metadata !583, metadata !"pp", metadata !48, i32 1604, metadata !57, i32 0, metadata !750} ; [ DW_TAG_auto_variable ] [pp] [line 1604]
!834 = metadata !{i32 1605, i32 0, metadata !583, metadata !750}
!835 = metadata !{i32 1606, i32 0, metadata !583, metadata !750}
!836 = metadata !{i32 1607, i32 0, metadata !583, metadata !750}
!837 = metadata !{i32 786689, metadata !589, metadata !"options", metadata !48, i32 16778783, metadata !183, i32 0, metadata !838} ; [ DW_TAG_arg_variable ] [options] [line 1567]
!838 = metadata !{i32 1608, i32 0, metadata !583, metadata !750}
!839 = metadata !{i32 1567, i32 0, metadata !589, metadata !838}
!840 = metadata !{i32 786689, metadata !589, metadata !"buf", metadata !48, i32 33555999, metadata !58, i32 0, metadata !838} ; [ DW_TAG_arg_variable ] [buf] [line 1567]
!841 = metadata !{i32 786689, metadata !589, metadata !"argv", metadata !48, i32 50333215, metadata !57, i32 0, metadata !838} ; [ DW_TAG_arg_variable ] [argv] [line 1567]
!842 = metadata !{i32 786688, metadata !589, metadata !"o", metadata !48, i32 1569, metadata !183, i32 0, metadata !838} ; [ DW_TAG_auto_variable ] [o] [line 1569]
!843 = metadata !{i32 1569, i32 0, metadata !589, metadata !838}
!844 = metadata !{i32 786688, metadata !589, metadata !"b", metadata !48, i32 1570, metadata !58, i32 0, metadata !838} ; [ DW_TAG_auto_variable ] [b] [line 1570]
!845 = metadata !{i32 1570, i32 0, metadata !589, metadata !838}
!846 = metadata !{i32 786688, metadata !589, metadata !"n", metadata !48, i32 1571, metadata !51, i32 0, metadata !838} ; [ DW_TAG_auto_variable ] [n] [line 1571]
!847 = metadata !{i32 1571, i32 0, metadata !589, metadata !838}
!848 = metadata !{i32 1573, i32 0, metadata !602, metadata !838}
!849 = metadata !{i32 1575, i32 0, metadata !600, metadata !838}
!850 = metadata !{i32 1576, i32 0, metadata !601, metadata !838}
!851 = metadata !{i32 1580, i32 0, metadata !852, metadata !838}
!852 = metadata !{i32 786443, metadata !1, metadata !601, i32 1579, i32 0, i32 373} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!853 = metadata !{i32 1584, i32 0, metadata !822, metadata !838}
!854 = metadata !{i32 1589, i32 0, metadata !601, metadata !838}
!855 = metadata !{i32 1583, i32 0, metadata !601, metadata !838}
!856 = metadata !{i32 1585, i32 0, metadata !822, metadata !838}
!857 = metadata !{i32 1588, i32 0, metadata !601, metadata !838}
!858 = metadata !{i32 1609, i32 0, metadata !583, metadata !750}
!859 = metadata !{i32 786689, metadata !557, metadata !"m", metadata !48, i32 16778704, metadata !183, i32 0, metadata !860} ; [ DW_TAG_arg_variable ] [m] [line 1488]
!860 = metadata !{i32 1795, i32 0, metadata !54, null}
!861 = metadata !{i32 1488, i32 0, metadata !557, metadata !860}
!862 = metadata !{i32 1495, i32 0, metadata !863, metadata !860}
!863 = metadata !{i32 786443, metadata !1, metadata !566, i32 1494, i32 0, i32 355} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!864 = metadata !{metadata !731, metadata !718, i64 8}
!865 = metadata !{i32 1496, i32 0, metadata !863, metadata !860}
!866 = metadata !{metadata !731, metadata !718, i64 16}
!867 = metadata !{i32 1497, i32 0, metadata !868, metadata !860}
!868 = metadata !{i32 786443, metadata !1, metadata !863, i32 1497, i32 0, i32 356} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!869 = metadata !{i32 1498, i32 0, metadata !868, metadata !860}
!870 = metadata !{i32 1623, i32 0, metadata !540, metadata !752}
!871 = metadata !{i32 1644, i32 0, metadata !872, metadata !752}
!872 = metadata !{i32 786443, metadata !1, metadata !873, i32 1644, i32 0, i32 350} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!873 = metadata !{i32 786443, metadata !1, metadata !540, i32 1631, i32 0, i32 346} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!874 = metadata !{i32 1649, i32 0, metadata !875, metadata !752}
!875 = metadata !{i32 786443, metadata !1, metadata !872, i32 1645, i32 0, i32 351} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!876 = metadata !{i32 410, i32 0, metadata !532, metadata !877}
!877 = metadata !{i32 1801, i32 0, metadata !134, null}
!878 = metadata !{i32 410, i32 0, metadata !532, metadata !879}
!879 = metadata !{i32 1805, i32 0, metadata !134, null}
!880 = metadata !{i32 786689, metadata !540, metadata !"argc", metadata !48, i32 16778835, metadata !51, i32 0, metadata !752} ; [ DW_TAG_arg_variable ] [argc] [line 1619]
!881 = metadata !{i32 786689, metadata !540, metadata !"argv", metadata !48, i32 33556051, metadata !543, i32 0, metadata !752} ; [ DW_TAG_arg_variable ] [argv] [line 1619]
!882 = metadata !{i32 786688, metadata !540, metadata !"p", metadata !48, i32 1624, metadata !58, i32 0, metadata !752} ; [ DW_TAG_auto_variable ] [p] [line 1624]
!883 = metadata !{i32 1624, i32 0, metadata !540, metadata !752}
!884 = metadata !{i32 786688, metadata !540, metadata !"was_digit", metadata !48, i32 1622, metadata !51, i32 0, metadata !752} ; [ DW_TAG_auto_variable ] [was_digit] [line 1622]
!885 = metadata !{i32 1626, i32 0, metadata !540, metadata !752}
!886 = metadata !{i32 1627, i32 0, metadata !540, metadata !752}
!887 = metadata !{i32 1628, i32 0, metadata !540, metadata !752}
!888 = metadata !{i32 1632, i32 0, metadata !889, metadata !752}
!889 = metadata !{i32 786443, metadata !1, metadata !873, i32 1632, i32 0, i32 347} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!890 = metadata !{i32 1641, i32 0, metadata !891, metadata !752}
!891 = metadata !{i32 786443, metadata !1, metadata !889, i32 1638, i32 0, i32 349} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!892 = metadata !{i32 1650, i32 0, metadata !875, metadata !752}
!893 = metadata !{i32 1651, i32 0, metadata !875, metadata !752}
!894 = metadata !{i32 1653, i32 0, metadata !873, metadata !752}
!895 = metadata !{i32 1}
!896 = metadata !{i32 1655, i32 0, metadata !873, metadata !752}
!897 = metadata !{i32 1656, i32 0, metadata !873, metadata !752}
!898 = metadata !{i32 1659, i32 0, metadata !787, metadata !752}
!899 = metadata !{i32 1661, i32 0, metadata !786, metadata !752}
!900 = metadata !{i32 786689, metadata !532, metadata !"str", metadata !48, i32 16777626, metadata !183, i32 0, metadata !785} ; [ DW_TAG_arg_variable ] [str] [line 410]
!901 = metadata !{i32 412, i32 0, metadata !539, metadata !785}
!902 = metadata !{i32 413, i32 0, metadata !903, metadata !785}
!903 = metadata !{i32 786443, metadata !1, metadata !539, i32 413, i32 0, i32 344} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!904 = metadata !{i32 786688, metadata !539, metadata !"value", metadata !48, i32 412, metadata !157, i32 0, metadata !785} ; [ DW_TAG_auto_variable ] [value] [line 412]
!905 = metadata !{i32 418, i32 0, metadata !906, metadata !785}
!906 = metadata !{i32 786443, metadata !1, metadata !903, i32 416, i32 0, i32 345} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!907 = metadata !{i32 417, i32 0, metadata !906, metadata !785}
!908 = metadata !{i32 419, i32 0, metadata !906, metadata !785}
!909 = metadata !{i32 1666, i32 0, metadata !540, metadata !752}
!910 = metadata !{i32 786689, metadata !532, metadata !"str", metadata !48, i32 16777626, metadata !183, i32 0, metadata !877} ; [ DW_TAG_arg_variable ] [str] [line 410]
!911 = metadata !{i32* @out_after}
!912 = metadata !{i32 786689, metadata !532, metadata !"out", metadata !48, i32 33554842, metadata !398, i32 0, metadata !877} ; [ DW_TAG_arg_variable ] [out] [line 410]
!913 = metadata !{i32 412, i32 0, metadata !539, metadata !877}
!914 = metadata !{i32 413, i32 0, metadata !903, metadata !877}
!915 = metadata !{i32 786688, metadata !539, metadata !"value", metadata !48, i32 412, metadata !157, i32 0, metadata !877} ; [ DW_TAG_auto_variable ] [value] [line 412]
!916 = metadata !{i32 418, i32 0, metadata !906, metadata !877}
!917 = metadata !{i32 417, i32 0, metadata !906, metadata !877}
!918 = metadata !{i32 419, i32 0, metadata !906, metadata !877}
!919 = metadata !{i32 786689, metadata !532, metadata !"str", metadata !48, i32 16777626, metadata !183, i32 0, metadata !879} ; [ DW_TAG_arg_variable ] [str] [line 410]
!920 = metadata !{i32* @out_before}
!921 = metadata !{i32 786689, metadata !532, metadata !"out", metadata !48, i32 33554842, metadata !398, i32 0, metadata !879} ; [ DW_TAG_arg_variable ] [out] [line 410]
!922 = metadata !{i32 412, i32 0, metadata !539, metadata !879}
!923 = metadata !{i32 413, i32 0, metadata !903, metadata !879}
!924 = metadata !{i32 786688, metadata !539, metadata !"value", metadata !48, i32 412, metadata !157, i32 0, metadata !879} ; [ DW_TAG_auto_variable ] [value] [line 412]
!925 = metadata !{i32 418, i32 0, metadata !906, metadata !879}
!926 = metadata !{i32 417, i32 0, metadata !906, metadata !879}
!927 = metadata !{i32 419, i32 0, metadata !906, metadata !879}
!928 = metadata !{i32 786689, metadata !532, metadata !"str", metadata !48, i32 16777626, metadata !183, i32 0, metadata !782} ; [ DW_TAG_arg_variable ] [str] [line 410]
!929 = metadata !{i32 412, i32 0, metadata !539, metadata !782}
!930 = metadata !{i32 413, i32 0, metadata !903, metadata !782}
!931 = metadata !{i32 786688, metadata !539, metadata !"value", metadata !48, i32 412, metadata !157, i32 0, metadata !782} ; [ DW_TAG_auto_variable ] [value] [line 412]
!932 = metadata !{i32 418, i32 0, metadata !906, metadata !782}
!933 = metadata !{i32 417, i32 0, metadata !906, metadata !782}
!934 = metadata !{i32 419, i32 0, metadata !906, metadata !782}
!935 = metadata !{i64 4}
!936 = metadata !{i32 1815, i32 0, metadata !132, null}
!937 = metadata !{i32 1816, i32 0, metadata !133, null}
!938 = metadata !{i32 1817, i32 0, metadata !143, null}
!939 = metadata !{i32 1818, i32 0, metadata !144, null}
!940 = metadata !{i32 1820, i32 0, metadata !144, null}
!941 = metadata !{i32 1824, i32 0, metadata !134, null}
!942 = metadata !{i32 1825, i32 0, metadata !134, null}
!943 = metadata !{i32 1828, i32 0, metadata !134, null}
!944 = metadata !{i32 1829, i32 0, metadata !134, null}
!945 = metadata !{i32 1832, i32 0, metadata !134, null}
!946 = metadata !{i32 1833, i32 0, metadata !134, null}
!947 = metadata !{i32 1836, i32 0, metadata !134, null}
!948 = metadata !{i32 1837, i32 0, metadata !134, null}
!949 = metadata !{i32 1840, i32 0, metadata !134, null}
!950 = metadata !{i32 1841, i32 0, metadata !134, null}
!951 = metadata !{i32 1844, i32 0, metadata !134, null}
!952 = metadata !{i32 1846, i32 0, metadata !134, null}
!953 = metadata !{i32 1849, i32 0, metadata !134, null}
!954 = metadata !{i32 1850, i32 0, metadata !134, null}
!955 = metadata !{i32 1854, i32 0, metadata !134, null}
!956 = metadata !{i32 1870, i32 0, metadata !134, null}
!957 = metadata !{i32 1873, i32 0, metadata !134, null}
!958 = metadata !{i32 1874, i32 0, metadata !134, null}
!959 = metadata !{i32 1878, i32 0, metadata !134, null}
!960 = metadata !{i32 1882, i32 0, metadata !134, null}
!961 = metadata !{i32 1885, i32 0, metadata !134, null}
!962 = metadata !{i32 1887, i32 0, metadata !134, null}
!963 = metadata !{i32 1890, i32 0, metadata !134, null}
!964 = metadata !{i32 1891, i32 0, metadata !134, null}
!965 = metadata !{i32 1892, i32 0, metadata !134, null}
!966 = metadata !{i32 1893, i32 0, metadata !134, null}
!967 = metadata !{i32 1894, i32 0, metadata !134, null}
!968 = metadata !{i32 1895, i32 0, metadata !134, null}
!969 = metadata !{i64 1}
!970 = metadata !{i32 1898, i32 0, metadata !150, null}
!971 = metadata !{i32 1898, i32 0, metadata !153, null}
!972 = metadata !{i32 1898, i32 0, metadata !973, null}
!973 = metadata !{i32 786443, metadata !1, metadata !153, i32 1898, i32 0, i32 23} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!974 = metadata !{i32 1898, i32 0, metadata !975, null}
!975 = metadata !{i32 786443, metadata !1, metadata !973, i32 1898, i32 0, i32 24} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!976 = metadata !{i32 1898, i32 0, metadata !134, null}
!977 = metadata !{i32 1899, i32 0, metadata !978, null}
!978 = metadata !{i32 786443, metadata !1, metadata !134, i32 1899, i32 0, i32 28} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!979 = metadata !{i32 1900, i32 0, metadata !978, null}
!980 = metadata !{i32 1901, i32 0, metadata !981, null}
!981 = metadata !{i32 786443, metadata !1, metadata !134, i32 1901, i32 0, i32 29} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!982 = metadata !{i32 1903, i32 0, metadata !134, null}
!983 = metadata !{i32 1904, i32 0, metadata !134, null}
!984 = metadata !{i32 128, i32 0, metadata !985, metadata !986}
!985 = metadata !{i32 786443, metadata !270, metadata !529} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src//usr/include/x86_64-linux-gnu/bits/stdio.h]
!986 = metadata !{i32 1905, i32 17, metadata !134, null}
!987 = metadata !{i32 1905, i32 0, metadata !134, null}
!988 = metadata !{i32 1906, i32 0, metadata !134, null}
!989 = metadata !{i32 786689, metadata !529, metadata !"__stream", metadata !271, i32 16777342, metadata !76, i32 0, metadata !986} ; [ DW_TAG_arg_variable ] [__stream] [line 126]
!990 = metadata !{i32 126, i32 0, metadata !529, metadata !986}
!991 = metadata !{metadata !992, metadata !779, i64 0}
!992 = metadata !{metadata !"_IO_FILE", metadata !779, i64 0, metadata !718, i64 8, metadata !718, i64 16, metadata !718, i64 24, metadata !718, i64 32, metadata !718, i64 40, metadata !718, i64 48, metadata !718, i64 56, metadata !718, i64 64, metadata !718, i64 72, metadata !718, i64 80, metadata !718, i64 88, metadata !718, i64 96, metadata !718, i64 104, metadata !779, i64 112, metadata !779, i64 116, metadata !776, i64 120, metadata !993, i64 128, metadata !719, i64 130, metadata !719, i64 131, metadata !718, i64 136, metadata !776, i64 144, metadata !718, i64 152, metadata !718, i64 160, metadata !718, i64 168, metadata !718, i64 176, metadata !776, i64 184, metadata !779, i64 192, metadata !719, i64 196}
!993 = metadata !{metadata !"short", metadata !719, i64 0}
!994 = metadata !{i32 1908, i32 0, metadata !995, null}
!995 = metadata !{i32 786443, metadata !1, metadata !134, i32 1907, i32 0, i32 30} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!996 = metadata !{i32 1909, i32 0, metadata !997, null}
!997 = metadata !{i32 786443, metadata !1, metadata !995, i32 1909, i32 0, i32 31} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!998 = metadata !{i32 1910, i32 0, metadata !997, null}
!999 = metadata !{i32 1912, i32 0, metadata !1000, null}
!1000 = metadata !{i32 786443, metadata !1, metadata !134, i32 1912, i32 0, i32 32} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1001 = metadata !{i32 1913, i32 0, metadata !1000, null}
!1002 = metadata !{i32 1915, i32 0, metadata !1003, null}
!1003 = metadata !{i32 786443, metadata !1, metadata !134, i32 1915, i32 0, i32 33} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1004 = metadata !{i32 1916, i32 0, metadata !1003, null}
!1005 = metadata !{i32 1920, i32 0, metadata !134, null}
!1006 = metadata !{i32 1922, i32 0, metadata !134, null}
!1007 = metadata !{i32 1926, i32 0, metadata !134, null}
!1008 = metadata !{i32 1927, i32 0, metadata !134, null}
!1009 = metadata !{i32 1932, i32 0, metadata !134, null}
!1010 = metadata !{i32 1933, i32 0, metadata !134, null}
!1011 = metadata !{i32 1936, i32 0, metadata !134, null}
!1012 = metadata !{i32 1937, i32 0, metadata !134, null}
!1013 = metadata !{i32 1941, i32 0, metadata !156, null}
!1014 = metadata !{i32 1942, i32 0, metadata !156, null}
!1015 = metadata !{i32 1945, i32 0, metadata !1016, null}
!1016 = metadata !{i32 786443, metadata !1, metadata !156, i32 1943, i32 0, i32 35} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1017 = metadata !{i32 1946, i32 0, metadata !1018, null}
!1018 = metadata !{i32 786443, metadata !1, metadata !1016, i32 1946, i32 0, i32 36} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1019 = metadata !{i32 1950, i32 0, metadata !1016, null}
!1020 = metadata !{i32 1951, i32 0, metadata !1016, null}
!1021 = metadata !{i32 1954, i32 0, metadata !1016, null}
!1022 = metadata !{i32 1955, i32 0, metadata !1016, null}
!1023 = metadata !{i32 1961, i32 0, metadata !134, null}
!1024 = metadata !{i32 1965, i32 0, metadata !134, null}
!1025 = metadata !{i32 1969, i32 0, metadata !134, null}
!1026 = metadata !{i32 1970, i32 0, metadata !134, null}
!1027 = metadata !{i32 1974, i32 0, metadata !134, null}
!1028 = metadata !{i32 1975, i32 0, metadata !134, null}
!1029 = metadata !{i32 1979, i32 0, metadata !134, null}
!1030 = metadata !{i32 1982, i32 0, metadata !134, null}
!1031 = metadata !{i32 1983, i32 0, metadata !134, null}
!1032 = metadata !{i32 1986, i32 0, metadata !134, null}
!1033 = metadata !{i32 1987, i32 0, metadata !134, null}
!1034 = metadata !{i32 1990, i32 0, metadata !134, null}
!1035 = metadata !{i32 1991, i32 0, metadata !134, null}
!1036 = metadata !{i32 1995, i32 0, metadata !134, null}
!1037 = metadata !{i32 1998, i32 0, metadata !134, null}
!1038 = metadata !{i32 1999, i32 0, metadata !134, null}
!1039 = metadata !{i64 6}
!1040 = metadata !{i32 2002, i32 0, metadata !160, null}
!1041 = metadata !{i32 2003, i32 0, metadata !161, null}
!1042 = metadata !{i32 2004, i32 0, metadata !167, null}
!1043 = metadata !{i32 2005, i32 0, metadata !168, null}
!1044 = metadata !{i64 13}
!1045 = metadata !{i32 2006, i32 0, metadata !174, null}
!1046 = metadata !{i32 2007, i32 0, metadata !175, null}
!1047 = metadata !{i32 2009, i32 0, metadata !175, null}
!1048 = metadata !{i32 2013, i32 0, metadata !1049, null}
!1049 = metadata !{i32 786443, metadata !1, metadata !134, i32 2013, i32 0, i32 61} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1050 = metadata !{i32 2014, i32 0, metadata !1051, null}
!1051 = metadata !{i32 786443, metadata !1, metadata !1052, i32 2014, i32 0, i32 63} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1052 = metadata !{i32 786443, metadata !1, metadata !1049, i32 2013, i32 0, i32 62} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1053 = metadata !{i32 2015, i32 0, metadata !1051, null}
!1054 = metadata !{i32 2016, i32 0, metadata !1051, null}
!1055 = metadata !{i32 2017, i32 0, metadata !1056, null}
!1056 = metadata !{i32 786443, metadata !1, metadata !1051, i32 2017, i32 0, i32 64} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1057 = metadata !{i32 2018, i32 0, metadata !1056, null}
!1058 = metadata !{i32 2019, i32 0, metadata !1056, null}
!1059 = metadata !{i32 2020, i32 0, metadata !1060, null}
!1060 = metadata !{i32 786443, metadata !1, metadata !1056, i32 2020, i32 0, i32 65} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1061 = metadata !{i32 2021, i32 0, metadata !1060, null}
!1062 = metadata !{i32 2022, i32 0, metadata !1060, null}
!1063 = metadata !{i32 2026, i32 0, metadata !1049, null}
!1064 = metadata !{i32 2024, i32 0, metadata !1060, null}
!1065 = metadata !{i32 2027, i32 0, metadata !182, null}
!1066 = metadata !{i32 2030, i32 0, metadata !187, null}
!1067 = metadata !{i32 2031, i32 0, metadata !186, null}
!1068 = metadata !{i32 2032, i32 0, metadata !187, null}
!1069 = metadata !{i32 2034, i32 0, metadata !187, null}
!1070 = metadata !{i32 2039, i32 0, metadata !1071, null}
!1071 = metadata !{i32 786443, metadata !1, metadata !134, i32 2039, i32 0, i32 76} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1072 = metadata !{i32 2040, i32 0, metadata !1071, null}
!1073 = metadata !{i32 2041, i32 0, metadata !134, null}
!1074 = metadata !{i32 2042, i32 0, metadata !134, null}
!1075 = metadata !{i32 2044, i32 0, metadata !1076, null}
!1076 = metadata !{i32 786443, metadata !1, metadata !134, i32 2044, i32 0, i32 77} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1077 = metadata !{i32 2045, i32 0, metadata !1076, null}
!1078 = metadata !{i32 2046, i32 0, metadata !1079, null}
!1079 = metadata !{i32 786443, metadata !1, metadata !134, i32 2046, i32 0, i32 78} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1080 = metadata !{i32 2049, i32 0, metadata !1081, null}
!1081 = metadata !{i32 786443, metadata !1, metadata !1079, i32 2048, i32 0, i32 79} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1082 = metadata !{i32 2050, i32 0, metadata !1081, null}
!1083 = metadata !{i32 2054, i32 0, metadata !1084, null}
!1084 = metadata !{i32 786443, metadata !1, metadata !134, i32 2054, i32 0, i32 80} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1085 = metadata !{i32 2055, i32 0, metadata !1084, null}
!1086 = metadata !{i32 2056, i32 0, metadata !134, null}
!1087 = metadata !{i32 2057, i32 0, metadata !134, null}
!1088 = metadata !{i32 2060, i32 0, metadata !1089, null}
!1089 = metadata !{i32 786443, metadata !1, metadata !134, i32 2060, i32 0, i32 81} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1090 = metadata !{i32 2061, i32 0, metadata !1089, null}
!1091 = metadata !{i32 2062, i32 0, metadata !134, null}
!1092 = metadata !{i32 2064, i32 0, metadata !134, null}
!1093 = metadata !{i32 2067, i32 0, metadata !134, null}
!1094 = metadata !{i32 2068, i32 0, metadata !134, null}
!1095 = metadata !{i32 2072, i32 0, metadata !134, null}
!1096 = metadata !{i32 2075, i32 0, metadata !134, null}
!1097 = metadata !{i32 2076, i32 0, metadata !134, null}
!1098 = metadata !{i32 2084, i32 0, metadata !134, null}
!1099 = metadata !{i32 2091, i32 0, metadata !1100, null}
!1100 = metadata !{i32 786443, metadata !1, metadata !54, i32 2091, i32 0, i32 82} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1101 = metadata !{i32 2093, i32 0, metadata !1102, null}
!1102 = metadata !{i32 786443, metadata !1, metadata !54, i32 2093, i32 0, i32 83} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1103 = metadata !{i32 2092, i32 0, metadata !1100, null}
!1104 = metadata !{i32 2098, i32 0, metadata !54, null}
!1105 = metadata !{i32 2096, i32 0, metadata !1106, null}
!1106 = metadata !{i32 786443, metadata !1, metadata !1102, i32 2094, i32 0, i32 84} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1107 = metadata !{i32 2097, i32 0, metadata !1106, null}
!1108 = metadata !{i32 2100, i32 0, metadata !792, null}
!1109 = metadata !{i32 2102, i32 0, metadata !794, null}
!1110 = metadata !{i32 2105, i32 0, metadata !194, null}
!1111 = metadata !{i32 2108, i32 0, metadata !193, null}
!1112 = metadata !{i32 2109, i32 0, metadata !1113, null}
!1113 = metadata !{i32 786443, metadata !1, metadata !193, i32 2109, i32 0, i32 89} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1114 = metadata !{i32 2110, i32 0, metadata !1113, null}
!1115 = metadata !{i32 1680, i32 0, metadata !497, metadata !1116}
!1116 = metadata !{i32 2113, i32 0, metadata !193, null}
!1117 = metadata !{i32 786688, metadata !497, metadata !"p", metadata !48, i32 1675, metadata !183, i32 0, metadata !1116} ; [ DW_TAG_auto_variable ] [p] [line 1675]
!1118 = metadata !{i32 1681, i32 0, metadata !1119, metadata !1116}
!1119 = metadata !{i32 786443, metadata !1, metadata !497, i32 1681, i32 0, i32 321} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1120 = metadata !{i32 1685, i32 0, metadata !497, metadata !1116}
!1121 = metadata !{i32 786688, metadata !497, metadata !"q", metadata !48, i32 1676, metadata !58, i32 0, metadata !1116} ; [ DW_TAG_auto_variable ] [q] [line 1676]
!1122 = metadata !{i32 1686, i32 0, metadata !1123, metadata !1116}
!1123 = metadata !{i32 786443, metadata !1, metadata !497, i32 1686, i32 0, i32 322} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1124 = metadata !{i32 1688, i32 0, metadata !497, metadata !1116}
!1125 = metadata !{i32 786688, metadata !497, metadata !"name", metadata !48, i32 1677, metadata !58, i32 0, metadata !1116} ; [ DW_TAG_auto_variable ] [name] [line 1677]
!1126 = metadata !{i32 1690, i32 0, metadata !497, metadata !1116}
!1127 = metadata !{i32 786688, metadata !497, metadata !"val", metadata !48, i32 1678, metadata !58, i32 0, metadata !1116} ; [ DW_TAG_auto_variable ] [val] [line 1678]
!1128 = metadata !{i32 1691, i32 0, metadata !497, metadata !1116}
!1129 = metadata !{i32 1693, i32 0, metadata !506, metadata !1116}
!1130 = metadata !{i32 1741, i32 0, metadata !1131, metadata !1116}
!1131 = metadata !{i32 786443, metadata !1, metadata !1132, i32 1741, i32 0, i32 342} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1132 = metadata !{i32 786443, metadata !1, metadata !505, i32 1734, i32 0, i32 339} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1133 = metadata !{i32 1694, i32 0, metadata !505, metadata !1116}
!1134 = metadata !{i32 786688, metadata !504, metadata !"c", metadata !48, i32 1696, metadata !59, i32 0, metadata !1116} ; [ DW_TAG_auto_variable ] [c] [line 1696]
!1135 = metadata !{i32 1696, i32 0, metadata !504, metadata !1116}
!1136 = metadata !{i32 1699, i32 0, metadata !504, metadata !1116}
!1137 = metadata !{null}
!1138 = metadata !{i32 786688, metadata !504, metadata !"cap", metadata !48, i32 1697, metadata !508, i32 0, metadata !1116} ; [ DW_TAG_auto_variable ] [cap] [line 1697]
!1139 = metadata !{i32 1702, i32 0, metadata !521, metadata !1116}
!1140 = metadata !{metadata !1141, metadata !718, i64 0}
!1141 = metadata !{metadata !"color_cap", metadata !718, i64 0, metadata !718, i64 8, metadata !718, i64 16}
!1142 = metadata !{i32 1703, i32 0, metadata !519, metadata !1116}
!1143 = metadata !{i32 1706, i32 0, metadata !1144, metadata !1116}
!1144 = metadata !{i32 786443, metadata !1, metadata !504, i32 1706, i32 0, i32 329} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1145 = metadata !{i32 1708, i32 0, metadata !1146, metadata !1116}
!1146 = metadata !{i32 786443, metadata !1, metadata !1147, i32 1708, i32 0, i32 331} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1147 = metadata !{i32 786443, metadata !1, metadata !1144, i32 1707, i32 0, i32 330} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1148 = metadata !{i32 1710, i32 0, metadata !1149, metadata !1116}
!1149 = metadata !{i32 786443, metadata !1, metadata !1150, i32 1710, i32 0, i32 333} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1150 = metadata !{i32 786443, metadata !1, metadata !1146, i32 1709, i32 0, i32 332} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1151 = metadata !{i32 1711, i32 0, metadata !1149, metadata !1116}
!1152 = metadata !{i32 1713, i32 0, metadata !1149, metadata !1116}
!1153 = metadata !{i32 1716, i32 0, metadata !1154, metadata !1116}
!1154 = metadata !{i32 786443, metadata !1, metadata !1146, i32 1716, i32 0, i32 334} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1155 = metadata !{i32 1717, i32 0, metadata !1154, metadata !1116}
!1156 = metadata !{i32 1721, i32 0, metadata !525, metadata !1116}
!1157 = metadata !{metadata !1141, metadata !718, i64 16}
!1158 = metadata !{i32 1723, i32 0, metadata !524, metadata !1116}
!1159 = metadata !{i32 786688, metadata !524, metadata !"err_str", metadata !48, i32 1723, metadata !183, i32 0, metadata !1116} ; [ DW_TAG_auto_variable ] [err_str] [line 1723]
!1160 = metadata !{i32 1725, i32 0, metadata !1161, metadata !1116}
!1161 = metadata !{i32 786443, metadata !1, metadata !524, i32 1725, i32 0, i32 337} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1162 = metadata !{i32 1726, i32 0, metadata !1161, metadata !1116}
!1163 = metadata !{i32 1729, i32 0, metadata !1164, metadata !1116}
!1164 = metadata !{i32 786443, metadata !1, metadata !504, i32 1729, i32 0, i32 338} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1165 = metadata !{i32 1736, i32 0, metadata !1166, metadata !1116}
!1166 = metadata !{i32 786443, metadata !1, metadata !1167, i32 1736, i32 0, i32 341} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1167 = metadata !{i32 786443, metadata !1, metadata !1132, i32 1735, i32 0, i32 340} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1168 = metadata !{i32 1738, i32 0, metadata !1167, metadata !1116}
!1169 = metadata !{i32 1739, i32 0, metadata !1167, metadata !1116}
!1170 = metadata !{i32 1740, i32 0, metadata !1167, metadata !1116}
!1171 = metadata !{i32 1742, i32 0, metadata !1131, metadata !1116}
!1172 = metadata !{i32 1743, i32 0, metadata !1173, metadata !1116}
!1173 = metadata !{i32 786443, metadata !1, metadata !1131, i32 1743, i32 0, i32 343} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1174 = metadata !{i32 1744, i32 0, metadata !1173, metadata !1116}
!1175 = metadata !{i32 1749, i32 0, metadata !497, metadata !1116}
!1176 = metadata !{i32 1751, i32 0, metadata !497, metadata !1116}
!1177 = metadata !{i32 2116, i32 0, metadata !1178, null}
!1178 = metadata !{i32 786443, metadata !1, metadata !54, i32 2116, i32 0, i32 90} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1179 = metadata !{i32 2118, i32 0, metadata !1180, null}
!1180 = metadata !{i32 786443, metadata !1, metadata !1178, i32 2117, i32 0, i32 91} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1181 = metadata !{i32 2120, i32 0, metadata !1180, null}
!1182 = metadata !{i32 2123, i32 0, metadata !1183, null}
!1183 = metadata !{i32 786443, metadata !1, metadata !54, i32 2123, i32 0, i32 92} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1184 = metadata !{i32 2124, i32 0, metadata !1183, null}
!1185 = metadata !{i32 2126, i32 0, metadata !755, null}
!1186 = metadata !{i32 2128, i32 0, metadata !1187, null}
!1187 = metadata !{i32 786443, metadata !1, metadata !1188, i32 2128, i32 0, i32 95} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1188 = metadata !{i32 786443, metadata !1, metadata !755, i32 2127, i32 0, i32 94} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1189 = metadata !{i32 2131, i32 0, metadata !1190, null}
!1190 = metadata !{i32 786443, metadata !1, metadata !1187, i32 2129, i32 0, i32 96} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1191 = metadata !{i32 2132, i32 0, metadata !1190, null}
!1192 = metadata !{i32 2133, i32 0, metadata !1190, null}
!1193 = metadata !{i32 2136, i32 0, metadata !1187, null}
!1194 = metadata !{i32 2143, i32 0, metadata !763, null}
!1195 = metadata !{i32 2147, i32 0, metadata !754, null}
!1196 = metadata !{i32 2150, i32 0, metadata !54, null}
!1197 = metadata !{i32 2151, i32 0, metadata !54, null}
!1198 = metadata !{i32 2154, i32 0, metadata !757, null}
!1199 = metadata !{i32 2159, i32 0, metadata !1200, null}
!1200 = metadata !{i32 786443, metadata !1, metadata !54, i32 2159, i32 0, i32 100} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1201 = metadata !{i32 2163, i32 0, metadata !1202, null}
!1202 = metadata !{i32 786443, metadata !1, metadata !54, i32 2163, i32 0, i32 101} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1203 = metadata !{i32 2164, i32 0, metadata !1202, null}
!1204 = metadata !{i32 2172, i32 0, metadata !1205, null}
!1205 = metadata !{i32 786443, metadata !1, metadata !196, i32 2172, i32 0, i32 105} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1206 = metadata !{i32 2173, i32 0, metadata !1205, null}
!1207 = metadata !{i32 2175, i32 0, metadata !1208, null}
!1208 = metadata !{i32 786443, metadata !1, metadata !1209, i32 2175, i32 0, i32 107} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1209 = metadata !{i32 786443, metadata !1, metadata !1205, i32 2174, i32 0, i32 106} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1210 = metadata !{i32 2176, i32 0, metadata !1208, null}
!1211 = metadata !{i32 2178, i32 0, metadata !1212, null}
!1212 = metadata !{i32 786443, metadata !1, metadata !1209, i32 2178, i32 0, i32 108} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1213 = metadata !{i32 2179, i32 0, metadata !1212, null}
!1214 = metadata !{i32 2182, i32 0, metadata !200, null}
!1215 = metadata !{i32 2182, i32 0, metadata !203, null}
!1216 = metadata !{i32 2182, i32 0, metadata !1217, null}
!1217 = metadata !{i32 786443, metadata !1, metadata !203, i32 2182, i32 0, i32 111} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1218 = metadata !{i32 2182, i32 0, metadata !1219, null}
!1219 = metadata !{i32 786443, metadata !1, metadata !1217, i32 2182, i32 0, i32 112} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1220 = metadata !{i32 2182, i32 0, metadata !1221, null}
!1221 = metadata !{i32 786443, metadata !1, metadata !1219, i32 2182, i32 0, i32 113} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1222 = metadata !{i32 2182, i32 0, metadata !196, null}
!1223 = metadata !{i32 2188, i32 0, metadata !198, null}
!1224 = metadata !{i32 2191, i32 0, metadata !54, null}
!1225 = metadata !{i32 1488, i32 0, metadata !557, null}
!1226 = metadata !{i32 1493, i32 0, metadata !566, null}
!1227 = metadata !{i32 1495, i32 0, metadata !863, null}
!1228 = metadata !{i32 1496, i32 0, metadata !863, null}
!1229 = metadata !{i32 1497, i32 0, metadata !868, null}
!1230 = metadata !{i32 1498, i32 0, metadata !868, null}
!1231 = metadata !{i32 1501, i32 0, metadata !565, null}
!1232 = metadata !{i32 1515, i32 0, metadata !571, null}
!1233 = metadata !{i32 1503, i32 0, metadata !562, null}
!1234 = metadata !{i32 1506, i32 0, metadata !1235, null}
!1235 = metadata !{i32 786443, metadata !1, metadata !563, i32 1506, i32 0, i32 361} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1236 = metadata !{i32 1507, i32 0, metadata !1235, null}
!1237 = metadata !{i32 1510, i32 0, metadata !1235, null}
!1238 = metadata !{i32 1516, i32 0, metadata !569, null}
!1239 = metadata !{i32 1518, i32 0, metadata !1240, null}
!1240 = metadata !{i32 786443, metadata !1, metadata !570, i32 1517, i32 0, i32 366} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1241 = metadata !{i32 1519, i32 0, metadata !1240, null}
!1242 = metadata !{i32 1520, i32 0, metadata !1240, null}
!1243 = metadata !{i32 1521, i32 0, metadata !1240, null}
!1244 = metadata !{i32 1524, i32 0, metadata !572, null}
!1245 = metadata !{i32 1526, i32 0, metadata !557, null}
!1246 = metadata !{i32 1190, i32 0, metadata !205, null}
!1247 = metadata !{i32 1196, i32 0, metadata !261, null}
!1248 = metadata !{i32 1198, i32 0, metadata !1249, null}
!1249 = metadata !{i32 786443, metadata !1, metadata !261, i32 1197, i32 0, i32 117} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1250 = metadata !{i32 1199, i32 0, metadata !1249, null}
!1251 = metadata !{i32 1203, i32 11, metadata !1252, null}
!1252 = metadata !{i32 786443, metadata !1, metadata !260, i32 1203, i32 0, i32 119} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1253 = metadata !{i32 786689, metadata !487, metadata !"__path", metadata !489, i32 16777671, metadata !183, i32 0, metadata !1251} ; [ DW_TAG_arg_variable ] [__path] [line 455]
!1254 = metadata !{i32 455, i32 0, metadata !487, metadata !1251}
!1255 = metadata !{i32 786689, metadata !487, metadata !"__statbuf", metadata !489, i32 33554887, metadata !492, i32 0, metadata !1251} ; [ DW_TAG_arg_variable ] [__statbuf] [line 455]
!1256 = metadata !{i32 457, i32 0, metadata !1257, metadata !1251}
!1257 = metadata !{i32 786443, metadata !488, metadata !487} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src//usr/include/x86_64-linux-gnu/sys/stat.h]
!1258 = metadata !{i32 786689, metadata !481, metadata !"mesg", metadata !48, i32 16777615, metadata !183, i32 0, metadata !1259} ; [ DW_TAG_arg_variable ] [mesg] [line 399]
!1259 = metadata !{i32 1205, i32 0, metadata !1260, null}
!1260 = metadata !{i32 786443, metadata !1, metadata !1252, i32 1204, i32 0, i32 120} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1261 = metadata !{i32 399, i32 0, metadata !481, metadata !1259}
!1262 = metadata !{i32 786689, metadata !481, metadata !"errnum", metadata !48, i32 33554831, metadata !51, i32 0, metadata !1259} ; [ DW_TAG_arg_variable ] [errnum] [line 399]
!1263 = metadata !{i32 401, i32 0, metadata !1264, metadata !1259}
!1264 = metadata !{i32 786443, metadata !1, metadata !481, i32 401, i32 0, i32 320} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1265 = metadata !{i32 402, i32 0, metadata !1264, metadata !1259}
!1266 = metadata !{i32 1206, i32 0, metadata !1260, null}
!1267 = metadata !{i32 1208, i32 0, metadata !1268, null}
!1268 = metadata !{i32 786443, metadata !1, metadata !260, i32 1208, i32 0, i32 121} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1269 = metadata !{metadata !1270, metadata !779, i64 32}
!1270 = metadata !{metadata !"stats", metadata !718, i64 0, metadata !1271, i64 8}
!1271 = metadata !{metadata !"stat", metadata !776, i64 0, metadata !776, i64 8, metadata !776, i64 16, metadata !779, i64 24, metadata !779, i64 28, metadata !779, i64 32, metadata !779, i64 36, metadata !776, i64 40, metadata !776, i64 48, metadata !776, i64 56, metadata !776, i64 64, metadata !1272, i64 72, metadata !1272, i64 88, metadata !1272, i64 104, metadata !719, i64 120}
!1272 = metadata !{metadata !"timespec", metadata !776, i64 0, metadata !776, i64 8}
!1273 = metadata !{i32 1210, i32 0, metadata !1274, null}
!1274 = metadata !{i32 786443, metadata !1, metadata !260, i32 1210, i32 0, i32 122} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1275 = metadata !{i32 1215, i32 0, metadata !260, null}
!1276 = metadata !{i32 1220, i32 0, metadata !258, null}
!1277 = metadata !{i32 1222, i32 0, metadata !1278, null}
!1278 = metadata !{i32 786443, metadata !1, metadata !258, i32 1222, i32 0, i32 125} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1279 = metadata !{i32 786689, metadata !487, metadata !"__path", metadata !489, i32 16777671, metadata !183, i32 0, metadata !1280} ; [ DW_TAG_arg_variable ] [__path] [line 455]
!1280 = metadata !{i32 1224, i32 19, metadata !1281, null}
!1281 = metadata !{i32 786443, metadata !1, metadata !1282, i32 1224, i32 0, i32 127} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1282 = metadata !{i32 786443, metadata !1, metadata !1278, i32 1223, i32 0, i32 126} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1283 = metadata !{i32 455, i32 0, metadata !487, metadata !1280}
!1284 = metadata !{i32 786689, metadata !487, metadata !"__statbuf", metadata !489, i32 33554887, metadata !492, i32 0, metadata !1280} ; [ DW_TAG_arg_variable ] [__statbuf] [line 455]
!1285 = metadata !{i32 457, i32 0, metadata !1257, metadata !1280}
!1286 = metadata !{i32 1226, i32 0, metadata !1287, null}
!1287 = metadata !{i32 786443, metadata !1, metadata !1281, i32 1225, i32 0, i32 128} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1288 = metadata !{i32 1227, i32 0, metadata !1287, null}
!1289 = metadata !{i32 1230, i32 0, metadata !1282, null}
!1290 = metadata !{i32 1233, i32 0, metadata !1291, null}
!1291 = metadata !{i32 786443, metadata !1, metadata !258, i32 1233, i32 0, i32 129} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1292 = metadata !{i32 1235, i32 0, metadata !1293, null}
!1293 = metadata !{i32 786443, metadata !1, metadata !1294, i32 1235, i32 0, i32 131} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1294 = metadata !{i32 786443, metadata !1, metadata !1291, i32 1234, i32 0, i32 130} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1295 = metadata !{i32 1236, i32 0, metadata !1293, null}
!1296 = metadata !{i32 1245, i32 0, metadata !1297, null}
!1297 = metadata !{i32 786443, metadata !1, metadata !1298, i32 1245, i32 0, i32 133} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1298 = metadata !{i32 786443, metadata !1, metadata !1293, i32 1237, i32 0, i32 132} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1299 = metadata !{i32 786689, metadata !481, metadata !"mesg", metadata !48, i32 16777615, metadata !183, i32 0, metadata !1300} ; [ DW_TAG_arg_variable ] [mesg] [line 399]
!1300 = metadata !{i32 1251, i32 0, metadata !258, null}
!1301 = metadata !{i32 399, i32 0, metadata !481, metadata !1300}
!1302 = metadata !{i32 786689, metadata !481, metadata !"errnum", metadata !48, i32 33554831, metadata !51, i32 0, metadata !1300} ; [ DW_TAG_arg_variable ] [errnum] [line 399]
!1303 = metadata !{i32 401, i32 0, metadata !1264, metadata !1300}
!1304 = metadata !{i32 402, i32 0, metadata !1264, metadata !1300}
!1305 = metadata !{i32 1252, i32 0, metadata !258, null}
!1306 = metadata !{i32 1255, i32 0, metadata !260, null}
!1307 = metadata !{i32 1261, i32 0, metadata !1308, null}
!1308 = metadata !{i32 786443, metadata !1, metadata !205, i32 1261, i32 0, i32 134} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1309 = metadata !{i32 786689, metadata !285, metadata !"fd", metadata !48, i32 16778275, metadata !51, i32 0, metadata !1310} ; [ DW_TAG_arg_variable ] [fd] [line 1059]
!1310 = metadata !{i32 1265, i32 0, metadata !205, null}
!1311 = metadata !{i32 1059, i32 0, metadata !285, metadata !1310}
!1312 = metadata !{i32 786689, metadata !285, metadata !"file", metadata !48, i32 33555491, metadata !183, i32 0, metadata !1310} ; [ DW_TAG_arg_variable ] [file] [line 1059]
!1313 = metadata !{i32 786689, metadata !285, metadata !"stats", metadata !48, i32 50332707, metadata !208, i32 0, metadata !1310} ; [ DW_TAG_arg_variable ] [stats] [line 1059]
!1314 = metadata !{i32 1067, i32 0, metadata !285, metadata !1310}
!1315 = metadata !{i32 786688, metadata !285, metadata !"eol", metadata !48, i32 1067, metadata !59, i32 0, metadata !1310} ; [ DW_TAG_auto_variable ] [eol] [line 1067]
!1316 = metadata !{i32 786689, metadata !458, metadata !"fd", metadata !48, i32 16777665, metadata !51, i32 0, metadata !1317} ; [ DW_TAG_arg_variable ] [fd] [line 449]
!1317 = metadata !{i32 1069, i32 0, metadata !1318, metadata !1310}
!1318 = metadata !{i32 786443, metadata !1, metadata !285, i32 1069, i32 0, i32 157} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1319 = metadata !{i32 449, i32 0, metadata !458, metadata !1317}
!1320 = metadata !{i32 786689, metadata !458, metadata !"file", metadata !48, i32 33554881, metadata !183, i32 0, metadata !1317} ; [ DW_TAG_arg_variable ] [file] [line 449]
!1321 = metadata !{i32 786689, metadata !458, metadata !"stats", metadata !48, i32 50332097, metadata !208, i32 0, metadata !1317} ; [ DW_TAG_arg_variable ] [stats] [line 449]
!1322 = metadata !{i32 451, i32 0, metadata !1323, metadata !1317}
!1323 = metadata !{i32 786443, metadata !1, metadata !458, i32 451, i32 0, i32 299} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1324 = metadata !{i32 460, i32 0, metadata !458, metadata !1317}
!1325 = metadata !{i32 453, i32 0, metadata !1326, metadata !1317}
!1326 = metadata !{i32 786443, metadata !1, metadata !1323, i32 452, i32 0, i32 300} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1327 = metadata !{i32 454, i32 0, metadata !1328, metadata !1317}
!1328 = metadata !{i32 786443, metadata !1, metadata !1326, i32 454, i32 0, i32 301} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1329 = metadata !{i32 455, i32 0, metadata !1328, metadata !1317}
!1330 = metadata !{i32 456, i32 0, metadata !1326, metadata !1317}
!1331 = metadata !{i32 457, i32 0, metadata !1326, metadata !1317}
!1332 = metadata !{i32 458, i32 0, metadata !1326, metadata !1317}
!1333 = metadata !{i32 461, i32 0, metadata !458, metadata !1317}
!1334 = metadata !{i32 462, i32 0, metadata !458, metadata !1317}
!1335 = metadata !{i32 464, i32 0, metadata !1336, metadata !1317}
!1336 = metadata !{i32 786443, metadata !1, metadata !458, i32 464, i32 0, i32 302} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1337 = metadata !{i32 466, i32 0, metadata !1338, metadata !1317}
!1338 = metadata !{i32 786443, metadata !1, metadata !1339, i32 466, i32 0, i32 304} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1339 = metadata !{i32 786443, metadata !1, metadata !1336, i32 465, i32 0, i32 303} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1340 = metadata !{i32 467, i32 0, metadata !1338, metadata !1317}
!1341 = metadata !{i32 470, i32 0, metadata !1342, metadata !1317}
!1342 = metadata !{i32 786443, metadata !1, metadata !1338, i32 469, i32 0, i32 305} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1343 = metadata !{i32 471, i32 0, metadata !1344, metadata !1317}
!1344 = metadata !{i32 786443, metadata !1, metadata !1342, i32 471, i32 0, i32 306} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1345 = metadata !{i32 473, i32 0, metadata !1346, metadata !1317}
!1346 = metadata !{i32 786443, metadata !1, metadata !1344, i32 472, i32 0, i32 307} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1347 = metadata !{i32 1072, i32 0, metadata !1348, metadata !1310}
!1348 = metadata !{i32 786443, metadata !1, metadata !285, i32 1072, i32 0, i32 158} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1349 = metadata !{i32 1077, i32 0, metadata !1350, metadata !1310}
!1350 = metadata !{i32 786443, metadata !1, metadata !1351, i32 1077, i32 0, i32 160} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1351 = metadata !{i32 786443, metadata !1, metadata !1348, i32 1074, i32 0, i32 159} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1352 = metadata !{i32 1078, i32 0, metadata !1350, metadata !1310}
!1353 = metadata !{i32 1079, i32 0, metadata !1351, metadata !1310}
!1354 = metadata !{i32 1082, i32 0, metadata !285, metadata !1310}
!1355 = metadata !{i32 1083, i32 0, metadata !285, metadata !1310}
!1356 = metadata !{i32 1084, i32 0, metadata !285, metadata !1310}
!1357 = metadata !{i32 1085, i32 0, metadata !285, metadata !1310}
!1358 = metadata !{i32 1086, i32 0, metadata !285, metadata !1310}
!1359 = metadata !{i32 1087, i32 0, metadata !285, metadata !1310}
!1360 = metadata !{i32 786688, metadata !285, metadata !"nlines", metadata !48, i32 1061, metadata !51, i32 0, metadata !1310} ; [ DW_TAG_auto_variable ] [nlines] [line 1061]
!1361 = metadata !{i32 1089, i32 0, metadata !285, metadata !1310}
!1362 = metadata !{i32 786688, metadata !285, metadata !"residue", metadata !48, i32 1063, metadata !65, i32 0, metadata !1310} ; [ DW_TAG_auto_variable ] [residue] [line 1063]
!1363 = metadata !{i32 1090, i32 0, metadata !285, metadata !1310}
!1364 = metadata !{i32 786688, metadata !285, metadata !"save", metadata !48, i32 1063, metadata !65, i32 0, metadata !1310} ; [ DW_TAG_auto_variable ] [save] [line 1063]
!1365 = metadata !{i32 1091, i32 0, metadata !285, metadata !1310}
!1366 = metadata !{i32 1093, i32 0, metadata !1367, metadata !1310}
!1367 = metadata !{i32 786443, metadata !1, metadata !285, i32 1093, i32 0, i32 161} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1368 = metadata !{i32 1095, i32 0, metadata !1369, metadata !1310}
!1369 = metadata !{i32 786443, metadata !1, metadata !1370, i32 1095, i32 0, i32 163} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1370 = metadata !{i32 786443, metadata !1, metadata !1367, i32 1094, i32 0, i32 162} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1371 = metadata !{i32 786689, metadata !481, metadata !"mesg", metadata !48, i32 16777615, metadata !183, i32 0, metadata !1372} ; [ DW_TAG_arg_variable ] [mesg] [line 399]
!1372 = metadata !{i32 1096, i32 0, metadata !1369, metadata !1310}
!1373 = metadata !{i32 399, i32 0, metadata !481, metadata !1372}
!1374 = metadata !{i32 786689, metadata !481, metadata !"errnum", metadata !48, i32 33554831, metadata !51, i32 0, metadata !1372} ; [ DW_TAG_arg_variable ] [errnum] [line 399]
!1375 = metadata !{i32 401, i32 0, metadata !1264, metadata !1372}
!1376 = metadata !{i32 402, i32 0, metadata !1264, metadata !1372}
!1377 = metadata !{i32 1100, i32 0, metadata !285, metadata !1310}
!1378 = metadata !{i32 1102, i32 0, metadata !285, metadata !1310}
!1379 = metadata !{i32 786688, metadata !285, metadata !"not_text", metadata !48, i32 1062, metadata !51, i32 0, metadata !1310} ; [ DW_TAG_auto_variable ] [not_text] [line 1062]
!1380 = metadata !{i32 1062, i32 0, metadata !285, metadata !1310}
!1381 = metadata !{i32 1103, i32 0, metadata !1382, metadata !1310}
!1382 = metadata !{i32 786443, metadata !1, metadata !285, i32 1103, i32 0, i32 164} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1383 = metadata !{i32 1105, i32 0, metadata !285, metadata !1310}
!1384 = metadata !{i32 1106, i32 0, metadata !285, metadata !1310}
!1385 = metadata !{i32 1108, i32 0, metadata !1386, metadata !1310}
!1386 = metadata !{i32 786443, metadata !1, metadata !285, i32 1108, i32 0, i32 165} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1387 = metadata !{i32 1110, i32 0, metadata !1388, metadata !1310}
!1388 = metadata !{i32 786443, metadata !1, metadata !1386, i32 1109, i32 0, i32 166} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1389 = metadata !{i32 1111, i32 0, metadata !1390, metadata !1310}
!1390 = metadata !{i32 786443, metadata !1, metadata !1388, i32 1111, i32 0, i32 167} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1391 = metadata !{i32 1112, i32 0, metadata !1390, metadata !1310}
!1392 = metadata !{i32 1114, i32 0, metadata !1388, metadata !1310}
!1393 = metadata !{i32 786688, metadata !285, metadata !"beg", metadata !48, i32 1065, metadata !58, i32 0, metadata !1310} ; [ DW_TAG_auto_variable ] [beg] [line 1065]
!1394 = metadata !{i32 1117, i32 0, metadata !1395, metadata !1310}
!1395 = metadata !{i32 786443, metadata !1, metadata !1388, i32 1117, i32 0, i32 168} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1396 = metadata !{i32 1122, i32 0, metadata !1388, metadata !1310}
!1397 = metadata !{i32 786688, metadata !285, metadata !"oldc", metadata !48, i32 1064, metadata !59, i32 0, metadata !1310} ; [ DW_TAG_auto_variable ] [oldc] [line 1064]
!1398 = metadata !{i32 1123, i32 0, metadata !1388, metadata !1310}
!1399 = metadata !{i32 1124, i32 0, metadata !1400, metadata !1310}
!1400 = metadata !{i32 786443, metadata !1, metadata !1388, i32 1124, i32 0, i32 169} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1401 = metadata !{i32 786688, metadata !285, metadata !"lim", metadata !48, i32 1066, metadata !58, i32 0, metadata !1310} ; [ DW_TAG_auto_variable ] [lim] [line 1066]
!1402 = metadata !{i32 1126, i32 0, metadata !1388, metadata !1310}
!1403 = metadata !{i32 1127, i32 0, metadata !1404, metadata !1310}
!1404 = metadata !{i32 786443, metadata !1, metadata !1388, i32 1127, i32 0, i32 170} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1405 = metadata !{i32 1128, i32 0, metadata !1404, metadata !1310}
!1406 = metadata !{i32 1130, i32 0, metadata !1388, metadata !1310}
!1407 = metadata !{i32 1129, i32 0, metadata !1388, metadata !1310}
!1408 = metadata !{i32 1132, i32 0, metadata !1409, metadata !1310}
!1409 = metadata !{i32 786443, metadata !1, metadata !1388, i32 1132, i32 0, i32 171} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1410 = metadata !{i32 1134, i32 0, metadata !1411, metadata !1310}
!1411 = metadata !{i32 786443, metadata !1, metadata !1412, i32 1134, i32 0, i32 173} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1412 = metadata !{i32 786443, metadata !1, metadata !1409, i32 1133, i32 0, i32 172} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1413 = metadata !{i32 1135, i32 0, metadata !1411, metadata !1310}
!1414 = metadata !{i32 1136, i32 0, metadata !1415, metadata !1310}
!1415 = metadata !{i32 786443, metadata !1, metadata !1412, i32 1136, i32 0, i32 174} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1416 = metadata !{i32 1137, i32 0, metadata !1415, metadata !1310}
!1417 = metadata !{i32 1138, i32 0, metadata !1418, metadata !1310}
!1418 = metadata !{i32 786443, metadata !1, metadata !1412, i32 1138, i32 0, i32 175} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1419 = metadata !{i32 786688, metadata !285, metadata !"i", metadata !48, i32 1061, metadata !51, i32 0, metadata !1310} ; [ DW_TAG_auto_variable ] [i] [line 1061]
!1420 = metadata !{i32 1145, i32 0, metadata !1388, metadata !1310}
!1421 = metadata !{i32 1146, i32 0, metadata !1388, metadata !1310}
!1422 = metadata !{i32 1147, i32 0, metadata !1388, metadata !1310}
!1423 = metadata !{i32 1149, i32 0, metadata !1424, metadata !1310}
!1424 = metadata !{i32 786443, metadata !1, metadata !1388, i32 1148, i32 0, i32 176} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1425 = metadata !{i32 1150, i32 0, metadata !1424, metadata !1310}
!1426 = metadata !{i32 1151, i32 0, metadata !1424, metadata !1310}
!1427 = metadata !{i32 1156, i32 0, metadata !1428, metadata !1310}
!1428 = metadata !{i32 786443, metadata !1, metadata !1388, i32 1156, i32 0, i32 177} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1429 = metadata !{i32 1157, i32 0, metadata !1428, metadata !1310}
!1430 = metadata !{i32 1160, i32 0, metadata !1388, metadata !1310}
!1431 = metadata !{i32 1161, i32 0, metadata !1432, metadata !1310}
!1432 = metadata !{i32 786443, metadata !1, metadata !1388, i32 1161, i32 0, i32 178} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1433 = metadata !{i32 1162, i32 0, metadata !1432, metadata !1310}
!1434 = metadata !{i32 786689, metadata !308, metadata !"a", metadata !48, i32 16777832, metadata !157, i32 0, metadata !1433} ; [ DW_TAG_arg_variable ] [a] [line 616]
!1435 = metadata !{i32 616, i32 0, metadata !308, metadata !1433}
!1436 = metadata !{i32 786689, metadata !308, metadata !"b", metadata !48, i32 33555048, metadata !157, i32 0, metadata !1433} ; [ DW_TAG_arg_variable ] [b] [line 616]
!1437 = metadata !{i32 618, i32 0, metadata !308, metadata !1433}
!1438 = metadata !{i32 786688, metadata !308, metadata !"sum", metadata !48, i32 618, metadata !157, i32 0, metadata !1433} ; [ DW_TAG_auto_variable ] [sum] [line 618]
!1439 = metadata !{i32 619, i32 0, metadata !1440, metadata !1433}
!1440 = metadata !{i32 786443, metadata !1, metadata !308, i32 619, i32 0, i32 191} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1441 = metadata !{i32 620, i32 0, metadata !1440, metadata !1433}
!1442 = metadata !{i32 1163, i32 0, metadata !1443, metadata !1310}
!1443 = metadata !{i32 786443, metadata !1, metadata !1388, i32 1163, i32 0, i32 179} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1444 = metadata !{i32 786689, metadata !301, metadata !"lim", metadata !48, i32 16777841, metadata !183, i32 0, metadata !1445} ; [ DW_TAG_arg_variable ] [lim] [line 625]
!1445 = metadata !{i32 1164, i32 0, metadata !1443, metadata !1310}
!1446 = metadata !{i32 625, i32 0, metadata !301, metadata !1445}
!1447 = metadata !{i32 786688, metadata !301, metadata !"newlines", metadata !48, i32 627, metadata !65, i32 0, metadata !1445} ; [ DW_TAG_auto_variable ] [newlines] [line 627]
!1448 = metadata !{i32 627, i32 0, metadata !301, metadata !1445}
!1449 = metadata !{i32 629, i32 0, metadata !1450, metadata !1445}
!1450 = metadata !{i32 786443, metadata !1, metadata !301, i32 629, i32 0, i32 188} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1451 = metadata !{i32 786688, metadata !301, metadata !"beg", metadata !48, i32 628, metadata !183, i32 0, metadata !1445} ; [ DW_TAG_auto_variable ] [beg] [line 628]
!1452 = metadata !{i32 631, i32 0, metadata !1453, metadata !1445}
!1453 = metadata !{i32 786443, metadata !1, metadata !1450, i32 630, i32 0, i32 189} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1454 = metadata !{i32 632, i32 0, metadata !1455, metadata !1445}
!1455 = metadata !{i32 786443, metadata !1, metadata !1453, i32 632, i32 0, i32 190} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1456 = metadata !{i32 634, i32 0, metadata !1453, metadata !1445}
!1457 = metadata !{i32 636, i32 0, metadata !301, metadata !1445}
!1458 = metadata !{i32 786689, metadata !308, metadata !"a", metadata !48, i32 16777832, metadata !157, i32 0, metadata !1457} ; [ DW_TAG_arg_variable ] [a] [line 616]
!1459 = metadata !{i32 616, i32 0, metadata !308, metadata !1457}
!1460 = metadata !{i32 786689, metadata !308, metadata !"b", metadata !48, i32 33555048, metadata !157, i32 0, metadata !1457} ; [ DW_TAG_arg_variable ] [b] [line 616]
!1461 = metadata !{i32 618, i32 0, metadata !308, metadata !1457}
!1462 = metadata !{i32 786688, metadata !308, metadata !"sum", metadata !48, i32 618, metadata !157, i32 0, metadata !1457} ; [ DW_TAG_auto_variable ] [sum] [line 618]
!1463 = metadata !{i32 619, i32 0, metadata !1440, metadata !1457}
!1464 = metadata !{i32 620, i32 0, metadata !1440, metadata !1457}
!1465 = metadata !{i32 637, i32 0, metadata !301, metadata !1445}
!1466 = metadata !{i32 1165, i32 0, metadata !1467, metadata !1310}
!1467 = metadata !{i32 786443, metadata !1, metadata !1388, i32 1165, i32 0, i32 180} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1468 = metadata !{i32 1167, i32 0, metadata !1469, metadata !1310}
!1469 = metadata !{i32 786443, metadata !1, metadata !1470, i32 1167, i32 0, i32 182} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1470 = metadata !{i32 786443, metadata !1, metadata !1467, i32 1166, i32 0, i32 181} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1471 = metadata !{i32 786689, metadata !481, metadata !"mesg", metadata !48, i32 16777615, metadata !183, i32 0, metadata !1472} ; [ DW_TAG_arg_variable ] [mesg] [line 399]
!1472 = metadata !{i32 1168, i32 0, metadata !1469, metadata !1310}
!1473 = metadata !{i32 399, i32 0, metadata !481, metadata !1472}
!1474 = metadata !{i32 786689, metadata !481, metadata !"errnum", metadata !48, i32 33554831, metadata !51, i32 0, metadata !1472} ; [ DW_TAG_arg_variable ] [errnum] [line 399]
!1475 = metadata !{i32 401, i32 0, metadata !1264, metadata !1472}
!1476 = metadata !{i32 402, i32 0, metadata !1264, metadata !1472}
!1477 = metadata !{i32 1172, i32 0, metadata !1478, metadata !1310}
!1478 = metadata !{i32 786443, metadata !1, metadata !285, i32 1172, i32 0, i32 183} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1479 = metadata !{i32 1174, i32 0, metadata !1480, metadata !1310}
!1480 = metadata !{i32 786443, metadata !1, metadata !1478, i32 1173, i32 0, i32 184} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1481 = metadata !{i32 1175, i32 0, metadata !1482, metadata !1310}
!1482 = metadata !{i32 786443, metadata !1, metadata !1480, i32 1175, i32 0, i32 185} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1483 = metadata !{i32 1176, i32 0, metadata !1482, metadata !1310}
!1484 = metadata !{i32 1177, i32 0, metadata !1485, metadata !1310}
!1485 = metadata !{i32 786443, metadata !1, metadata !1480, i32 1177, i32 0, i32 186} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1486 = metadata !{i32 1178, i32 0, metadata !1485, metadata !1310}
!1487 = metadata !{i32 1182, i32 0, metadata !285, metadata !1310}
!1488 = metadata !{i32 1183, i32 0, metadata !285, metadata !1310}
!1489 = metadata !{i32 1184, i32 0, metadata !1490, metadata !1310}
!1490 = metadata !{i32 786443, metadata !1, metadata !285, i32 1184, i32 0, i32 187} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1491 = metadata !{i32 1185, i32 0, metadata !1490, metadata !1310}
!1492 = metadata !{i32 1266, i32 0, metadata !266, null}
!1493 = metadata !{i32 1267, i32 0, metadata !266, null}
!1494 = metadata !{i32 1270, i32 0, metadata !1495, null}
!1495 = metadata !{i32 786443, metadata !1, metadata !265, i32 1270, i32 0, i32 137} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1496 = metadata !{i32 1272, i32 0, metadata !1497, null}
!1497 = metadata !{i32 786443, metadata !1, metadata !1498, i32 1272, i32 0, i32 139} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1498 = metadata !{i32 786443, metadata !1, metadata !1495, i32 1271, i32 0, i32 138} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1499 = metadata !{i32 644, i32 0, metadata !1500, metadata !1502}
!1500 = metadata !{i32 786443, metadata !1, metadata !1501, i32 644, i32 0, i32 154} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1501 = metadata !{i32 786443, metadata !1, metadata !282, i32 644, i32 0, i32 153} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1502 = metadata !{i32 1274, i32 0, metadata !1503, null}
!1503 = metadata !{i32 786443, metadata !1, metadata !1497, i32 1273, i32 0, i32 140} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1504 = metadata !{i32 645, i32 0, metadata !282, metadata !1502}
!1505 = metadata !{i32 646, i32 0, metadata !1506, metadata !1502}
!1506 = metadata !{i32 786443, metadata !1, metadata !1507, i32 646, i32 0, i32 156} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1507 = metadata !{i32 786443, metadata !1, metadata !282, i32 646, i32 0, i32 155} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1508 = metadata !{i32 1275, i32 0, metadata !1509, null}
!1509 = metadata !{i32 786443, metadata !1, metadata !1503, i32 1275, i32 0, i32 141} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1510 = metadata !{i8 58}
!1511 = metadata !{i32 786689, metadata !277, metadata !"sep", metadata !48, i32 16777867, metadata !59, i32 0, metadata !1512} ; [ DW_TAG_arg_variable ] [sep] [line 651]
!1512 = metadata !{i32 1276, i32 0, metadata !1509, null}
!1513 = metadata !{i32 651, i32 0, metadata !277, metadata !1512}
!1514 = metadata !{i32 653, i32 0, metadata !1515, metadata !1512}
!1515 = metadata !{i32 786443, metadata !1, metadata !1516, i32 653, i32 0, i32 150} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1516 = metadata !{i32 786443, metadata !1, metadata !1517, i32 653, i32 0, i32 149} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1517 = metadata !{i32 786443, metadata !1, metadata !277} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1518 = metadata !{i32 654, i32 0, metadata !1517, metadata !1512}
!1519 = metadata !{i32 58}
!1520 = metadata !{i32 786689, metadata !269, metadata !"__c", metadata !271, i32 16777305, metadata !51, i32 0, metadata !1518} ; [ DW_TAG_arg_variable ] [__c] [line 89]
!1521 = metadata !{i32 89, i32 0, metadata !269, metadata !1518}
!1522 = metadata !{i32 786689, metadata !269, metadata !"__stream", metadata !271, i32 33554521, metadata !76, i32 0, metadata !1518} ; [ DW_TAG_arg_variable ] [__stream] [line 89]
!1523 = metadata !{i32 91, i32 0, metadata !1524, metadata !1518}
!1524 = metadata !{i32 786443, metadata !270, metadata !269} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src//usr/include/x86_64-linux-gnu/bits/stdio.h]
!1525 = metadata !{metadata !992, metadata !718, i64 40}
!1526 = metadata !{metadata !992, metadata !718, i64 48}
!1527 = metadata !{metadata !"branch_weights", i32 64, i32 4}
!1528 = metadata !{i32 655, i32 0, metadata !1529, metadata !1512}
!1529 = metadata !{i32 786443, metadata !1, metadata !1530, i32 655, i32 0, i32 152} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1530 = metadata !{i32 786443, metadata !1, metadata !1517, i32 655, i32 0, i32 151} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1531 = metadata !{i32 1278, i32 0, metadata !1509, null}
!1532 = metadata !{i32 786689, metadata !269, metadata !"__c", metadata !271, i32 16777305, metadata !51, i32 0, metadata !1531} ; [ DW_TAG_arg_variable ] [__c] [line 89]
!1533 = metadata !{i32 89, i32 0, metadata !269, metadata !1531}
!1534 = metadata !{i32 786689, metadata !269, metadata !"__stream", metadata !271, i32 33554521, metadata !76, i32 0, metadata !1531} ; [ DW_TAG_arg_variable ] [__stream] [line 89]
!1535 = metadata !{i32 91, i32 0, metadata !1524, metadata !1531}
!1536 = metadata !{i32 1280, i32 0, metadata !1498, null}
!1537 = metadata !{i32 1281, i32 0, metadata !1498, null}
!1538 = metadata !{i32 1283, i32 0, metadata !265, null}
!1539 = metadata !{i32 1284, i32 0, metadata !1540, null}
!1540 = metadata !{i32 786443, metadata !1, metadata !265, i32 1284, i32 0, i32 142} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1541 = metadata !{i32 644, i32 0, metadata !1500, metadata !1542}
!1542 = metadata !{i32 1286, i32 0, metadata !1543, null}
!1543 = metadata !{i32 786443, metadata !1, metadata !1540, i32 1285, i32 0, i32 143} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1544 = metadata !{i32 645, i32 0, metadata !282, metadata !1542}
!1545 = metadata !{i32 646, i32 0, metadata !1506, metadata !1542}
!1546 = metadata !{i32 1287, i32 0, metadata !1543, null}
!1547 = metadata !{i32 786689, metadata !269, metadata !"__c", metadata !271, i32 16777305, metadata !51, i32 0, metadata !1546} ; [ DW_TAG_arg_variable ] [__c] [line 89]
!1548 = metadata !{i32 89, i32 0, metadata !269, metadata !1546}
!1549 = metadata !{i32 786689, metadata !269, metadata !"__stream", metadata !271, i32 33554521, metadata !76, i32 0, metadata !1546} ; [ DW_TAG_arg_variable ] [__stream] [line 89]
!1550 = metadata !{i32 91, i32 0, metadata !1524, metadata !1546}
!1551 = metadata !{i32 1290, i32 0, metadata !264, null}
!1552 = metadata !{i32 1292, i32 0, metadata !263, null}
!1553 = metadata !{i32 1293, i32 0, metadata !1554, null}
!1554 = metadata !{i32 786443, metadata !1, metadata !263, i32 1293, i32 0, i32 146} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1555 = metadata !{i32 1294, i32 0, metadata !1554, null}
!1556 = metadata !{i32 1296, i32 0, metadata !1554, null}
!1557 = metadata !{i32 1299, i32 0, metadata !264, null}
!1558 = metadata !{i32 1300, i32 0, metadata !1559, null}
!1559 = metadata !{i32 786443, metadata !1, metadata !264, i32 1300, i32 0, i32 147} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1560 = metadata !{i32 1302, i32 0, metadata !1561, null}
!1561 = metadata !{i32 786443, metadata !1, metadata !1559, i32 1301, i32 0, i32 148} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1562 = metadata !{i32 1303, i32 0, metadata !1561, null}
!1563 = metadata !{i32 1308, i32 0, metadata !205, null}
!1564 = metadata !{i32 1311, i32 0, metadata !463, null}
!1565 = metadata !{i32 1315, i32 0, metadata !463, null}
!1566 = metadata !{i32 1316, i32 0, metadata !1567, null}
!1567 = metadata !{i32 786443, metadata !1, metadata !463, i32 1316, i32 0, i32 308} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1568 = metadata !{i32 1317, i32 0, metadata !1567, null}
!1569 = metadata !{i32 1324, i32 0, metadata !1570, null}
!1570 = metadata !{i32 786443, metadata !1, metadata !463, i32 1324, i32 0, i32 310} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1571 = metadata !{metadata !1270, metadata !776, i64 16}
!1572 = metadata !{i32 1325, i32 0, metadata !1573, null}
!1573 = metadata !{i32 786443, metadata !1, metadata !1570, i32 1325, i32 0, i32 311} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1574 = metadata !{metadata !1270, metadata !718, i64 0}
!1575 = metadata !{i32 1326, i32 0, metadata !1576, null}
!1576 = metadata !{i32 786443, metadata !1, metadata !1573, i32 1326, i32 0, i32 312} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1577 = metadata !{metadata !1270, metadata !776, i64 8}
!1578 = metadata !{i32 1329, i32 0, metadata !1579, null}
!1579 = metadata !{i32 786443, metadata !1, metadata !1580, i32 1329, i32 0, i32 314} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1580 = metadata !{i32 786443, metadata !1, metadata !1576, i32 1328, i32 0, i32 313} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1581 = metadata !{i32 1330, i32 0, metadata !1579, null}
!1582 = metadata !{i32 1331, i32 0, metadata !1579, null}
!1583 = metadata !{i32 1335, i32 0, metadata !463, null}
!1584 = metadata !{metadata !1270, metadata !776, i64 56}
!1585 = metadata !{i32 1338, i32 0, metadata !474, null}
!1586 = metadata !{i32 1340, i32 0, metadata !1587, null}
!1587 = metadata !{i32 786443, metadata !1, metadata !1588, i32 1340, i32 0, i32 317} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1588 = metadata !{i32 786443, metadata !1, metadata !474, i32 1339, i32 0, i32 316} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1589 = metadata !{i32 786689, metadata !481, metadata !"mesg", metadata !48, i32 16777615, metadata !183, i32 0, metadata !1590} ; [ DW_TAG_arg_variable ] [mesg] [line 399]
!1590 = metadata !{i32 1341, i32 0, metadata !1587, null}
!1591 = metadata !{i32 399, i32 0, metadata !481, metadata !1590}
!1592 = metadata !{i32 786689, metadata !481, metadata !"errnum", metadata !48, i32 33554831, metadata !51, i32 0, metadata !1590} ; [ DW_TAG_arg_variable ] [errnum] [line 399]
!1593 = metadata !{i32 401, i32 0, metadata !1264, metadata !1590}
!1594 = metadata !{i32 402, i32 0, metadata !1264, metadata !1590}
!1595 = metadata !{i32 1344, i32 0, metadata !1588, null}
!1596 = metadata !{i32 1343, i32 0, metadata !1587, null}
!1597 = metadata !{i32 1347, i32 0, metadata !473, null}
!1598 = metadata !{i32 1348, i32 0, metadata !473, null}
!1599 = metadata !{i32 1350, i32 0, metadata !473, null}
!1600 = metadata !{i32 1351, i32 0, metadata !473, null}
!1601 = metadata !{i32 1352, i32 0, metadata !473, null}
!1602 = metadata !{i32 1353, i32 0, metadata !473, null}
!1603 = metadata !{i32 1354, i32 0, metadata !473, null}
!1604 = metadata !{i32 1355, i32 0, metadata !473, null}
!1605 = metadata !{i32 1358, i32 0, metadata !480, null}
!1606 = metadata !{i32 1361, i32 0, metadata !480, null}
!1607 = metadata !{i32 1357, i32 0, metadata !480, null}
!1608 = metadata !{i32 1359, i32 0, metadata !480, null}
!1609 = metadata !{i32 1360, i32 0, metadata !480, null}
!1610 = metadata !{i32 1362, i32 0, metadata !480, null}
!1611 = metadata !{i32 1363, i32 0, metadata !480, null}
!1612 = metadata !{i32 1365, i32 0, metadata !473, null}
!1613 = metadata !{i32 1366, i32 0, metadata !473, null}
!1614 = metadata !{i32 1367, i32 0, metadata !473, null}
!1615 = metadata !{i32 1368, i32 0, metadata !473, null}
!1616 = metadata !{i32 1371, i32 0, metadata !463, null}
!1617 = metadata !{i32 486, i32 0, metadata !432, null}
!1618 = metadata !{i32 488, i32 0, metadata !432, null}
!1619 = metadata !{i32 489, i32 0, metadata !432, null}
!1620 = metadata !{i32 495, i32 0, metadata !432, null}
!1621 = metadata !{i32 497, i32 0, metadata !445, null}
!1622 = metadata !{i32 499, i32 0, metadata !1623, null}
!1623 = metadata !{i32 786443, metadata !1, metadata !445, i32 498, i32 0, i32 287} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1624 = metadata !{i32 500, i32 0, metadata !1623, null}
!1625 = metadata !{i32 501, i32 0, metadata !1623, null}
!1626 = metadata !{i32 504, i32 0, metadata !444, null}
!1627 = metadata !{i32 510, i32 0, metadata !1628, null}
!1628 = metadata !{i32 786443, metadata !1, metadata !444, i32 510, i32 0, i32 289} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1629 = metadata !{i32 511, i32 0, metadata !1630, null}
!1630 = metadata !{i32 786443, metadata !1, metadata !1628, i32 511, i32 0, i32 290} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1631 = metadata !{i32 512, i32 0, metadata !1630, null}
!1632 = metadata !{i32 519, i32 0, metadata !451, null}
!1633 = metadata !{i32 521, i32 0, metadata !450, null}
!1634 = metadata !{i32 522, i32 0, metadata !450, null}
!1635 = metadata !{i32 523, i32 0, metadata !1636, null}
!1636 = metadata !{i32 786443, metadata !1, metadata !450, i32 523, i32 0, i32 293} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1637 = metadata !{i32 527, i32 0, metadata !1636, null}
!1638 = metadata !{i32 532, i32 0, metadata !444, null}
!1639 = metadata !{i32 534, i32 0, metadata !444, null}
!1640 = metadata !{i32 535, i32 0, metadata !444, null}
!1641 = metadata !{i32 536, i32 0, metadata !444, null}
!1642 = metadata !{i32 537, i32 0, metadata !444, null}
!1643 = metadata !{i32 538, i32 0, metadata !444, null}
!1644 = metadata !{i32 539, i32 0, metadata !1645, null}
!1645 = metadata !{i32 786443, metadata !1, metadata !444, i32 539, i32 0, i32 294} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1646 = metadata !{i32 541, i32 0, metadata !1647, null}
!1647 = metadata !{i32 786443, metadata !1, metadata !1645, i32 540, i32 0, i32 295} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1648 = metadata !{i32 542, i32 0, metadata !1647, null}
!1649 = metadata !{i32 543, i32 0, metadata !1647, null}
!1650 = metadata !{i32 546, i32 0, metadata !432, null}
!1651 = metadata !{i32 547, i32 0, metadata !432, null}
!1652 = metadata !{i32 549, i32 0, metadata !455, null}
!1653 = metadata !{i32 552, i32 0, metadata !454, null}
!1654 = metadata !{i32 553, i32 0, metadata !454, null}
!1655 = metadata !{i32 556, i32 0, metadata !1656, null}
!1656 = metadata !{i32 786443, metadata !1, metadata !454, i32 555, i32 0, i32 298} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1657 = metadata !{i32 561, i32 0, metadata !432, null}
!1658 = metadata !{i32 566, i32 0, metadata !432, null}
!1659 = metadata !{i32 567, i32 0, metadata !432, null}
!1660 = metadata !{i32 1006, i32 0, metadata !381, null}
!1661 = metadata !{i32 1008, i32 0, metadata !381, null}
!1662 = metadata !{i32 1011, i32 0, metadata !381, null}
!1663 = metadata !{i32 1013, i32 0, metadata !381, null}
!1664 = metadata !{i32 1014, i32 0, metadata !381, null}
!1665 = metadata !{i32 1015, i32 0, metadata !381, null}
!1666 = metadata !{i32 786689, metadata !417, metadata !"start_ptr", metadata !48, i32 67109826, metadata !183, i32 0, metadata !1665} ; [ DW_TAG_arg_variable ] [start_ptr] [line 962]
!1667 = metadata !{i32 962, i32 0, metadata !417, metadata !1665}
!1668 = metadata !{i32 979, i32 0, metadata !1669, metadata !1665}
!1669 = metadata !{i32 786443, metadata !1, metadata !417, i32 979, i32 0, i32 280} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1670 = metadata !{i32 982, i32 0, metadata !430, metadata !1665}
!1671 = metadata !{i32 985, i32 0, metadata !429, metadata !1665}
!1672 = metadata !{i32 980, i32 0, metadata !1669, metadata !1665}
!1673 = metadata !{i32 786688, metadata !429, metadata !"line_buf", metadata !48, i32 984, metadata !183, i32 0, metadata !1665} ; [ DW_TAG_auto_variable ] [line_buf] [line 984]
!1674 = metadata !{i32 984, i32 0, metadata !429, metadata !1665}
!1675 = metadata !{i32 786688, metadata !429, metadata !"line_end", metadata !48, i32 985, metadata !183, i32 0, metadata !1665} ; [ DW_TAG_auto_variable ] [line_end] [line 985]
!1676 = metadata !{i32 986, i32 0, metadata !1677, metadata !1665}
!1677 = metadata !{i32 786443, metadata !1, metadata !429, i32 986, i32 0, i32 283} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1678 = metadata !{i32 989, i32 0, metadata !1677, metadata !1665}
!1679 = metadata !{i32 786688, metadata !417, metadata !"line_next", metadata !48, i32 965, metadata !183, i32 0, metadata !1665} ; [ DW_TAG_auto_variable ] [line_next] [line 965]
!1680 = metadata !{i32 994, i32 0, metadata !429, metadata !1665}
!1681 = metadata !{i32 786688, metadata !417, metadata !"result", metadata !48, i32 964, metadata !65, i32 0, metadata !1665} ; [ DW_TAG_auto_variable ] [result] [line 964]
!1682 = metadata !{i32 995, i32 0, metadata !1683, metadata !1665}
!1683 = metadata !{i32 786443, metadata !1, metadata !429, i32 995, i32 0, i32 285} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1684 = metadata !{i32 996, i32 0, metadata !1683, metadata !1665}
!1685 = metadata !{i32 1018, i32 0, metadata !393, null}
!1686 = metadata !{i32 1019, i32 0, metadata !393, null}
!1687 = metadata !{i32 1021, i32 0, metadata !1688, null}
!1688 = metadata !{i32 786443, metadata !1, metadata !393, i32 1021, i32 0, i32 251} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1689 = metadata !{i32 1023, i32 0, metadata !1690, null}
!1690 = metadata !{i32 786443, metadata !1, metadata !393, i32 1023, i32 0, i32 252} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1691 = metadata !{i32 1025, i32 0, metadata !1692, null}
!1692 = metadata !{i32 786443, metadata !1, metadata !1690, i32 1024, i32 0, i32 253} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1693 = metadata !{i32 1026, i32 0, metadata !1692, null}
!1694 = metadata !{i32 1027, i32 0, metadata !1692, null}
!1695 = metadata !{i32 1028, i32 0, metadata !1696, null}
!1696 = metadata !{i32 786443, metadata !1, metadata !1692, i32 1028, i32 0, i32 254} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1697 = metadata !{i32 1030, i32 0, metadata !1698, null}
!1698 = metadata !{i32 786443, metadata !1, metadata !1699, i32 1030, i32 0, i32 256} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1699 = metadata !{i32 786443, metadata !1, metadata !1696, i32 1029, i32 0, i32 255} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1700 = metadata !{i32 1031, i32 0, metadata !1698, null}
!1701 = metadata !{i32 1032, i32 0, metadata !1699, null}
!1702 = metadata !{i32 1033, i32 0, metadata !1699, null}
!1703 = metadata !{i32 1036, i32 0, metadata !1704, null}
!1704 = metadata !{i32 786443, metadata !1, metadata !1690, i32 1036, i32 0, i32 257} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1705 = metadata !{i32 1038, i32 0, metadata !1706, null}
!1706 = metadata !{i32 786443, metadata !1, metadata !1704, i32 1037, i32 0, i32 258} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1707 = metadata !{i32 1039, i32 0, metadata !1706, null}
!1708 = metadata !{i32 1040, i32 0, metadata !1706, null}
!1709 = metadata !{i32 1041, i32 0, metadata !1710, null}
!1710 = metadata !{i32 786443, metadata !1, metadata !1706, i32 1041, i32 0, i32 259} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1711 = metadata !{i32 1046, i32 0, metadata !1712, null}
!1712 = metadata !{i32 786443, metadata !1, metadata !381, i32 1046, i32 0, i32 260} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1713 = metadata !{i32 1048, i32 0, metadata !1714, null}
!1714 = metadata !{i32 786443, metadata !1, metadata !1712, i32 1047, i32 0, i32 261} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1715 = metadata !{i32 1049, i32 0, metadata !1714, null}
!1716 = metadata !{i32 1050, i32 0, metadata !1714, null}
!1717 = metadata !{i32 1051, i32 0, metadata !1714, null}
!1718 = metadata !{i32 1053, i32 0, metadata !381, null}
!1719 = metadata !{i32 873, i32 0, metadata !315, null}
!1720 = metadata !{i32 875, i32 0, metadata !1721, null}
!1721 = metadata !{i32 786443, metadata !1, metadata !315, i32 875, i32 0, i32 192} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1722 = metadata !{i32 876, i32 0, metadata !1721, null}
!1723 = metadata !{i32 877, i32 0, metadata !315, null}
!1724 = metadata !{i32 879, i32 0, metadata !319, null}
!1725 = metadata !{i32 880, i32 0, metadata !319, null}
!1726 = metadata !{i32 881, i32 0, metadata !319, null}
!1727 = metadata !{i32 882, i32 0, metadata !1728, null}
!1728 = metadata !{i32 786443, metadata !1, metadata !319, i32 882, i32 0, i32 194} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1729 = metadata !{i32 886, i32 0, metadata !1728, null}
!1730 = metadata !{i32 883, i32 0, metadata !1728, null}
!1731 = metadata !{i32 888, i32 0, metadata !1728, null}
!1732 = metadata !{i32 890, i32 0, metadata !315, null}
!1733 = metadata !{i32 824, i32 0, metadata !321, null}
!1734 = metadata !{i32 830, i32 0, metadata !1735, null}
!1735 = metadata !{i32 786443, metadata !1, metadata !321, i32 830, i32 0, i32 195} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1736 = metadata !{i32 831, i32 0, metadata !1735, null}
!1737 = metadata !{i32 833, i32 0, metadata !321, null}
!1738 = metadata !{i32 835, i32 0, metadata !1739, null}
!1739 = metadata !{i32 786443, metadata !1, metadata !321, i32 835, i32 0, i32 196} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1740 = metadata !{i32 837, i32 0, metadata !1741, null}
!1741 = metadata !{i32 786443, metadata !1, metadata !1739, i32 836, i32 0, i32 197} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1742 = metadata !{i32 827, i32 0, metadata !321, null}
!1743 = metadata !{i32 840, i32 0, metadata !1741, null}
!1744 = metadata !{i32 842, i32 0, metadata !1741, null}
!1745 = metadata !{i32 846, i32 0, metadata !1746, null}
!1746 = metadata !{i32 786443, metadata !1, metadata !321, i32 846, i32 0, i32 198} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1747 = metadata !{i32 850, i32 0, metadata !1748, null}
!1748 = metadata !{i32 786443, metadata !1, metadata !1749, i32 850, i32 0, i32 200} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1749 = metadata !{i32 786443, metadata !1, metadata !1746, i32 848, i32 0, i32 199} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1750 = metadata !{i32 740, i32 0, metadata !346, metadata !1751}
!1751 = metadata !{i32 851, i32 0, metadata !1748, null}
!1752 = metadata !{i32 786689, metadata !346, metadata !"beg", metadata !48, i32 16777956, metadata !183, i32 0, metadata !1751} ; [ DW_TAG_arg_variable ] [beg] [line 740]
!1753 = metadata !{i32 786689, metadata !346, metadata !"lim", metadata !48, i32 33555172, metadata !183, i32 0, metadata !1751} ; [ DW_TAG_arg_variable ] [lim] [line 740]
!1754 = metadata !{i32 786689, metadata !346, metadata !"line_color", metadata !48, i32 50332389, metadata !183, i32 0, metadata !1751} ; [ DW_TAG_arg_variable ] [line_color] [line 741]
!1755 = metadata !{i32 741, i32 0, metadata !346, metadata !1751}
!1756 = metadata !{i32 786689, metadata !346, metadata !"match_color", metadata !48, i32 67109605, metadata !183, i32 0, metadata !1751} ; [ DW_TAG_arg_variable ] [match_color] [line 741]
!1757 = metadata !{i32 743, i32 0, metadata !346, metadata !1751}
!1758 = metadata !{i32 786688, metadata !346, metadata !"cur", metadata !48, i32 745, metadata !183, i32 0, metadata !1751} ; [ DW_TAG_auto_variable ] [cur] [line 745]
!1759 = metadata !{i32 745, i32 0, metadata !346, metadata !1751}
!1760 = metadata !{i32 786688, metadata !346, metadata !"mid", metadata !48, i32 746, metadata !183, i32 0, metadata !1751} ; [ DW_TAG_auto_variable ] [mid] [line 746]
!1761 = metadata !{i32 746, i32 0, metadata !346, metadata !1751}
!1762 = metadata !{i32 748, i32 0, metadata !346, metadata !1751}
!1763 = metadata !{i32 749, i32 0, metadata !346, metadata !1751}
!1764 = metadata !{i32 786688, metadata !346, metadata !"match_offset", metadata !48, i32 744, metadata !65, i32 0, metadata !1751} ; [ DW_TAG_auto_variable ] [match_offset] [line 744]
!1765 = metadata !{i32 752, i32 0, metadata !359, metadata !1751}
!1766 = metadata !{i32 786688, metadata !359, metadata !"b", metadata !48, i32 752, metadata !183, i32 0, metadata !1751} ; [ DW_TAG_auto_variable ] [b] [line 752]
!1767 = metadata !{i32 755, i32 0, metadata !1768, metadata !1751}
!1768 = metadata !{i32 786443, metadata !1, metadata !359, i32 755, i32 0, i32 212} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1769 = metadata !{i32 786688, metadata !346, metadata !"match_size", metadata !48, i32 743, metadata !65, i32 0, metadata !1751} ; [ DW_TAG_auto_variable ] [match_size] [line 743]
!1770 = metadata !{i32 759, i32 0, metadata !1771, metadata !1751}
!1771 = metadata !{i32 786443, metadata !1, metadata !359, i32 759, i32 0, i32 213} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1772 = metadata !{i32 763, i32 0, metadata !1773, metadata !1751}
!1773 = metadata !{i32 786443, metadata !1, metadata !1771, i32 760, i32 0, i32 214} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1774 = metadata !{i32 764, i32 0, metadata !1775, metadata !1751}
!1775 = metadata !{i32 786443, metadata !1, metadata !1773, i32 764, i32 0, i32 215} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1776 = metadata !{i32 765, i32 0, metadata !1775, metadata !1751}
!1777 = metadata !{i32 771, i32 0, metadata !1778, metadata !1751}
!1778 = metadata !{i32 786443, metadata !1, metadata !1779, i32 771, i32 0, i32 217} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1779 = metadata !{i32 786443, metadata !1, metadata !1771, i32 768, i32 0, i32 216} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1780 = metadata !{i32 772, i32 0, metadata !1778, metadata !1751}
!1781 = metadata !{i32 776, i32 0, metadata !1782, metadata !1751}
!1782 = metadata !{i32 786443, metadata !1, metadata !1783, i32 776, i32 0, i32 220} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1783 = metadata !{i32 786443, metadata !1, metadata !1784, i32 776, i32 0, i32 219} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1784 = metadata !{i32 786443, metadata !1, metadata !1778, i32 775, i32 0, i32 218} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1785 = metadata !{i32 777, i32 0, metadata !1786, metadata !1751}
!1786 = metadata !{i32 786443, metadata !1, metadata !1784, i32 777, i32 0, i32 221} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1787 = metadata !{i32 779, i32 0, metadata !1788, metadata !1751}
!1788 = metadata !{i32 786443, metadata !1, metadata !1786, i32 778, i32 0, i32 222} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1789 = metadata !{i32 780, i32 0, metadata !1788, metadata !1751}
!1790 = metadata !{i32 782, i32 0, metadata !1784, metadata !1751}
!1791 = metadata !{i32 785, i32 0, metadata !1792, metadata !1751}
!1792 = metadata !{i32 786443, metadata !1, metadata !1793, i32 785, i32 0, i32 224} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1793 = metadata !{i32 786443, metadata !1, metadata !1779, i32 785, i32 0, i32 223} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1794 = metadata !{i32 786, i32 0, metadata !1779, metadata !1751}
!1795 = metadata !{i32 787, i32 0, metadata !1796, metadata !1751}
!1796 = metadata !{i32 786443, metadata !1, metadata !1797, i32 787, i32 0, i32 226} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1797 = metadata !{i32 786443, metadata !1, metadata !1779, i32 787, i32 0, i32 225} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1798 = metadata !{i32 788, i32 0, metadata !1799, metadata !1751}
!1799 = metadata !{i32 786443, metadata !1, metadata !1779, i32 788, i32 0, i32 227} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1800 = metadata !{i32 789, i32 0, metadata !1799, metadata !1751}
!1801 = metadata !{i32 791, i32 0, metadata !359, metadata !1751}
!1802 = metadata !{i32 794, i32 0, metadata !1803, metadata !1751}
!1803 = metadata !{i32 786443, metadata !1, metadata !346, i32 794, i32 0, i32 228} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1804 = metadata !{i32 796, i32 0, metadata !1805, metadata !1751}
!1805 = metadata !{i32 786443, metadata !1, metadata !1803, i32 796, i32 0, i32 229} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1806 = metadata !{i32 797, i32 0, metadata !1805, metadata !1751}
!1807 = metadata !{i32 854, i32 0, metadata !1808, null}
!1808 = metadata !{i32 786443, metadata !1, metadata !1749, i32 854, i32 0, i32 201} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1809 = metadata !{i32 786689, metadata !336, metadata !"beg", metadata !48, i32 16778019, metadata !183, i32 0, metadata !1810} ; [ DW_TAG_arg_variable ] [beg] [line 803]
!1810 = metadata !{i32 855, i32 0, metadata !1808, null}
!1811 = metadata !{i32 803, i32 0, metadata !336, metadata !1810}
!1812 = metadata !{i32 786689, metadata !336, metadata !"lim", metadata !48, i32 33555235, metadata !183, i32 0, metadata !1810} ; [ DW_TAG_arg_variable ] [lim] [line 803]
!1813 = metadata !{i32 786689, metadata !336, metadata !"line_color", metadata !48, i32 50332451, metadata !183, i32 0, metadata !1810} ; [ DW_TAG_arg_variable ] [line_color] [line 803]
!1814 = metadata !{i32 808, i32 0, metadata !344, metadata !1810}
!1815 = metadata !{i32 786688, metadata !344, metadata !"eol_size", metadata !48, i32 805, metadata !65, i32 0, metadata !1810} ; [ DW_TAG_auto_variable ] [eol_size] [line 805]
!1816 = metadata !{i32 805, i32 0, metadata !344, metadata !1810}
!1817 = metadata !{i32 809, i32 0, metadata !344, metadata !1810}
!1818 = metadata !{i32 810, i32 0, metadata !344, metadata !1810}
!1819 = metadata !{i32 786688, metadata !344, metadata !"tail_size", metadata !48, i32 806, metadata !65, i32 0, metadata !1810} ; [ DW_TAG_auto_variable ] [tail_size] [line 806]
!1820 = metadata !{i32 812, i32 0, metadata !1821, metadata !1810}
!1821 = metadata !{i32 786443, metadata !1, metadata !344, i32 812, i32 0, i32 205} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1822 = metadata !{i32 814, i32 0, metadata !1823, metadata !1810}
!1823 = metadata !{i32 786443, metadata !1, metadata !1824, i32 814, i32 0, i32 208} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1824 = metadata !{i32 786443, metadata !1, metadata !1825, i32 814, i32 0, i32 207} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1825 = metadata !{i32 786443, metadata !1, metadata !1821, i32 813, i32 0, i32 206} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1826 = metadata !{i32 815, i32 0, metadata !1825, metadata !1810}
!1827 = metadata !{i32 816, i32 0, metadata !1825, metadata !1810}
!1828 = metadata !{i32 817, i32 0, metadata !1829, metadata !1810}
!1829 = metadata !{i32 786443, metadata !1, metadata !1830, i32 817, i32 0, i32 210} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1830 = metadata !{i32 786443, metadata !1, metadata !1825, i32 817, i32 0, i32 209} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1831 = metadata !{i32 858, i32 0, metadata !1832, null}
!1832 = metadata !{i32 786443, metadata !1, metadata !321, i32 858, i32 0, i32 202} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1833 = metadata !{i32 859, i32 0, metadata !1832, null}
!1834 = metadata !{i32 861, i32 7, metadata !1835, null}
!1835 = metadata !{i32 786443, metadata !1, metadata !321, i32 861, i32 0, i32 203} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1836 = metadata !{i32 786689, metadata !331, metadata !"__stream", metadata !271, i32 16777349, metadata !76, i32 0, metadata !1834} ; [ DW_TAG_arg_variable ] [__stream] [line 133]
!1837 = metadata !{i32 133, i32 0, metadata !331, metadata !1834}
!1838 = metadata !{i32 135, i32 0, metadata !1839, metadata !1834}
!1839 = metadata !{i32 786443, metadata !270, metadata !331} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src//usr/include/x86_64-linux-gnu/bits/stdio.h]
!1840 = metadata !{i32 862, i32 0, metadata !1835, null}
!1841 = metadata !{i32 864, i32 0, metadata !321, null}
!1842 = metadata !{i32 866, i32 0, metadata !1843, null}
!1843 = metadata !{i32 786443, metadata !1, metadata !321, i32 866, i32 0, i32 204} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1844 = metadata !{i32 867, i32 0, metadata !1843, null}
!1845 = metadata !{i32 868, i32 0, metadata !321, null}
!1846 = metadata !{i32 687, i32 0, metadata !360, null}
!1847 = metadata !{i32 689, i32 0, metadata !360, null}
!1848 = metadata !{i32 691, i32 0, metadata !1849, null}
!1849 = metadata !{i32 786443, metadata !1, metadata !360, i32 691, i32 0, i32 230} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1850 = metadata !{i32 644, i32 0, metadata !1500, metadata !1851}
!1851 = metadata !{i32 693, i32 0, metadata !1852, null}
!1852 = metadata !{i32 786443, metadata !1, metadata !1849, i32 692, i32 0, i32 231} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1853 = metadata !{i32 645, i32 0, metadata !282, metadata !1851}
!1854 = metadata !{i32 646, i32 0, metadata !1506, metadata !1851}
!1855 = metadata !{i32 694, i32 0, metadata !1856, null}
!1856 = metadata !{i32 786443, metadata !1, metadata !1852, i32 694, i32 0, i32 232} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1857 = metadata !{i32 697, i32 0, metadata !1856, null}
!1858 = metadata !{i32 786689, metadata !269, metadata !"__c", metadata !271, i32 16777305, metadata !51, i32 0, metadata !1857} ; [ DW_TAG_arg_variable ] [__c] [line 89]
!1859 = metadata !{i32 89, i32 0, metadata !269, metadata !1857}
!1860 = metadata !{i32 786689, metadata !269, metadata !"__stream", metadata !271, i32 33554521, metadata !76, i32 0, metadata !1857} ; [ DW_TAG_arg_variable ] [__stream] [line 89]
!1861 = metadata !{i32 91, i32 0, metadata !1524, metadata !1857}
!1862 = metadata !{i32 700, i32 0, metadata !1863, null}
!1863 = metadata !{i32 786443, metadata !1, metadata !360, i32 700, i32 0, i32 233} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1864 = metadata !{i32 702, i32 0, metadata !1865, null}
!1865 = metadata !{i32 786443, metadata !1, metadata !1866, i32 702, i32 0, i32 235} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1866 = metadata !{i32 786443, metadata !1, metadata !1863, i32 701, i32 0, i32 234} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1867 = metadata !{i32 786689, metadata !301, metadata !"lim", metadata !48, i32 16777841, metadata !183, i32 0, metadata !1868} ; [ DW_TAG_arg_variable ] [lim] [line 625]
!1868 = metadata !{i32 704, i32 0, metadata !1869, null}
!1869 = metadata !{i32 786443, metadata !1, metadata !1865, i32 703, i32 0, i32 236} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1870 = metadata !{i32 625, i32 0, metadata !301, metadata !1868}
!1871 = metadata !{i32 786688, metadata !301, metadata !"newlines", metadata !48, i32 627, metadata !65, i32 0, metadata !1868} ; [ DW_TAG_auto_variable ] [newlines] [line 627]
!1872 = metadata !{i32 627, i32 0, metadata !301, metadata !1868}
!1873 = metadata !{i32 786688, metadata !301, metadata !"beg", metadata !48, i32 628, metadata !183, i32 0, metadata !1868} ; [ DW_TAG_auto_variable ] [beg] [line 628]
!1874 = metadata !{i32 629, i32 0, metadata !1450, metadata !1868}
!1875 = metadata !{i32 631, i32 0, metadata !1453, metadata !1868}
!1876 = metadata !{i32 632, i32 0, metadata !1455, metadata !1868}
!1877 = metadata !{i32 634, i32 0, metadata !1453, metadata !1868}
!1878 = metadata !{i32 636, i32 0, metadata !301, metadata !1868}
!1879 = metadata !{i32 786689, metadata !308, metadata !"a", metadata !48, i32 16777832, metadata !157, i32 0, metadata !1878} ; [ DW_TAG_arg_variable ] [a] [line 616]
!1880 = metadata !{i32 616, i32 0, metadata !308, metadata !1878}
!1881 = metadata !{i32 786689, metadata !308, metadata !"b", metadata !48, i32 33555048, metadata !157, i32 0, metadata !1878} ; [ DW_TAG_arg_variable ] [b] [line 616]
!1882 = metadata !{i32 618, i32 0, metadata !308, metadata !1878}
!1883 = metadata !{i32 786688, metadata !308, metadata !"sum", metadata !48, i32 618, metadata !157, i32 0, metadata !1878} ; [ DW_TAG_auto_variable ] [sum] [line 618]
!1884 = metadata !{i32 619, i32 0, metadata !1440, metadata !1878}
!1885 = metadata !{i32 620, i32 0, metadata !1440, metadata !1878}
!1886 = metadata !{i32 637, i32 0, metadata !301, metadata !1868}
!1887 = metadata !{i32 786689, metadata !308, metadata !"a", metadata !48, i32 16777832, metadata !157, i32 0, metadata !1888} ; [ DW_TAG_arg_variable ] [a] [line 616]
!1888 = metadata !{i32 705, i32 0, metadata !1869, null}
!1889 = metadata !{i32 616, i32 0, metadata !308, metadata !1888}
!1890 = metadata !{i32 786689, metadata !308, metadata !"b", metadata !48, i32 33555048, metadata !157, i32 0, metadata !1888} ; [ DW_TAG_arg_variable ] [b] [line 616]
!1891 = metadata !{i32 618, i32 0, metadata !308, metadata !1888}
!1892 = metadata !{i32 786688, metadata !308, metadata !"sum", metadata !48, i32 618, metadata !157, i32 0, metadata !1888} ; [ DW_TAG_auto_variable ] [sum] [line 618]
!1893 = metadata !{i32 619, i32 0, metadata !1440, metadata !1888}
!1894 = metadata !{i32 620, i32 0, metadata !1440, metadata !1888}
!1895 = metadata !{i32 706, i32 0, metadata !1869, null}
!1896 = metadata !{i32 707, i32 0, metadata !1869, null}
!1897 = metadata !{i32 708, i32 0, metadata !1898, null}
!1898 = metadata !{i32 786443, metadata !1, metadata !1866, i32 708, i32 0, i32 237} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1899 = metadata !{i32 653, i32 0, metadata !1515, metadata !1900}
!1900 = metadata !{i32 709, i32 0, metadata !1898, null}
!1901 = metadata !{i32 654, i32 0, metadata !1517, metadata !1900}
!1902 = metadata !{i32 786689, metadata !269, metadata !"__c", metadata !271, i32 16777305, metadata !51, i32 0, metadata !1901} ; [ DW_TAG_arg_variable ] [__c] [line 89]
!1903 = metadata !{i32 89, i32 0, metadata !269, metadata !1901}
!1904 = metadata !{i32 786689, metadata !269, metadata !"__stream", metadata !271, i32 33554521, metadata !76, i32 0, metadata !1901} ; [ DW_TAG_arg_variable ] [__stream] [line 89]
!1905 = metadata !{i32 91, i32 0, metadata !1524, metadata !1901}
!1906 = metadata !{i32 655, i32 0, metadata !1529, metadata !1900}
!1907 = metadata !{i32 710, i32 0, metadata !1866, null}
!1908 = metadata !{i32 711, i32 0, metadata !1866, null}
!1909 = metadata !{i32 712, i32 0, metadata !1866, null}
!1910 = metadata !{i32 714, i32 0, metadata !368, null}
!1911 = metadata !{i32 716, i32 0, metadata !367, null}
!1912 = metadata !{i32 786689, metadata !308, metadata !"a", metadata !48, i32 16777832, metadata !157, i32 0, metadata !1911} ; [ DW_TAG_arg_variable ] [a] [line 616]
!1913 = metadata !{i32 616, i32 0, metadata !308, metadata !1911}
!1914 = metadata !{i32 786689, metadata !308, metadata !"b", metadata !48, i32 33555048, metadata !157, i32 0, metadata !1911} ; [ DW_TAG_arg_variable ] [b] [line 616]
!1915 = metadata !{i32 618, i32 0, metadata !308, metadata !1911}
!1916 = metadata !{i32 786688, metadata !308, metadata !"sum", metadata !48, i32 618, metadata !157, i32 0, metadata !1911} ; [ DW_TAG_auto_variable ] [sum] [line 618]
!1917 = metadata !{i32 619, i32 0, metadata !1440, metadata !1911}
!1918 = metadata !{i32 620, i32 0, metadata !1440, metadata !1911}
!1919 = metadata !{i32 720, i32 0, metadata !1920, null}
!1920 = metadata !{i32 786443, metadata !1, metadata !367, i32 720, i32 0, i32 240} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1921 = metadata !{i32 653, i32 0, metadata !1515, metadata !1922}
!1922 = metadata !{i32 721, i32 0, metadata !1920, null}
!1923 = metadata !{i32 654, i32 0, metadata !1517, metadata !1922}
!1924 = metadata !{i32 786689, metadata !269, metadata !"__c", metadata !271, i32 16777305, metadata !51, i32 0, metadata !1923} ; [ DW_TAG_arg_variable ] [__c] [line 89]
!1925 = metadata !{i32 89, i32 0, metadata !269, metadata !1923}
!1926 = metadata !{i32 786689, metadata !269, metadata !"__stream", metadata !271, i32 33554521, metadata !76, i32 0, metadata !1923} ; [ DW_TAG_arg_variable ] [__stream] [line 89]
!1927 = metadata !{i32 91, i32 0, metadata !1524, metadata !1923}
!1928 = metadata !{i32 655, i32 0, metadata !1529, metadata !1922}
!1929 = metadata !{i32 722, i32 0, metadata !367, null}
!1930 = metadata !{i32 723, i32 0, metadata !367, null}
!1931 = metadata !{i32 726, i32 0, metadata !1932, null}
!1932 = metadata !{i32 786443, metadata !1, metadata !360, i32 726, i32 0, i32 241} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1933 = metadata !{i32 732, i32 0, metadata !1934, null}
!1934 = metadata !{i32 786443, metadata !1, metadata !1935, i32 732, i32 0, i32 243} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1935 = metadata !{i32 786443, metadata !1, metadata !1932, i32 727, i32 0, i32 242} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1936 = metadata !{i32 733, i32 0, metadata !1934, null}
!1937 = metadata !{i32 653, i32 0, metadata !1515, metadata !1938}
!1938 = metadata !{i32 735, i32 0, metadata !1935, null}
!1939 = metadata !{i32 654, i32 0, metadata !1517, metadata !1938}
!1940 = metadata !{i32 786689, metadata !269, metadata !"__c", metadata !271, i32 16777305, metadata !51, i32 0, metadata !1939} ; [ DW_TAG_arg_variable ] [__c] [line 89]
!1941 = metadata !{i32 89, i32 0, metadata !269, metadata !1939}
!1942 = metadata !{i32 786689, metadata !269, metadata !"__stream", metadata !271, i32 33554521, metadata !76, i32 0, metadata !1939} ; [ DW_TAG_arg_variable ] [__stream] [line 89]
!1943 = metadata !{i32 91, i32 0, metadata !1524, metadata !1939}
!1944 = metadata !{i32 655, i32 0, metadata !1529, metadata !1938}
!1945 = metadata !{i32 737, i32 0, metadata !360, null}
!1946 = metadata !{i32 660, i32 0, metadata !369, null}
!1947 = metadata !{i32 665, i32 0, metadata !369, null}
!1948 = metadata !{i32 666, i32 0, metadata !369, null}
!1949 = metadata !{i32 668, i32 0, metadata !369, null}
!1950 = metadata !{i32 670, i32 0, metadata !1951, null}
!1951 = metadata !{i32 786443, metadata !1, metadata !369, i32 669, i32 0, i32 244} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1952 = metadata !{i32 671, i32 0, metadata !1951, null}
!1953 = metadata !{i32 672, i32 0, metadata !1951, null}
!1954 = metadata !{i32 677, i32 0, metadata !1955, null}
!1955 = metadata !{i32 786443, metadata !1, metadata !369, i32 676, i32 0, i32 245} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1956 = metadata !{i32 676, i32 0, metadata !1955, null}
!1957 = metadata !{i32 678, i32 0, metadata !1955, null}
!1958 = metadata !{metadata !1958, metadata !1959, metadata !1960}
!1959 = metadata !{metadata !"llvm.vectorizer.width", i32 1}
!1960 = metadata !{metadata !"llvm.vectorizer.unroll", i32 1}
!1961 = metadata !{metadata !1961, metadata !1959, metadata !1960}
!1962 = metadata !{i32 680, i32 0, metadata !1963, null}
!1963 = metadata !{i32 786443, metadata !1, metadata !1964, i32 680, i32 0, i32 247} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1964 = metadata !{i32 786443, metadata !1, metadata !369, i32 680, i32 0, i32 246} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1965 = metadata !{i32 681, i32 0, metadata !369, null}
!1966 = metadata !{i32 682, i32 0, metadata !1967, null}
!1967 = metadata !{i32 786443, metadata !1, metadata !1968, i32 682, i32 0, i32 249} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1968 = metadata !{i32 786443, metadata !1, metadata !369, i32 682, i32 0, i32 248} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1969 = metadata !{i32 683, i32 0, metadata !369, null}
!1970 = metadata !{i32 895, i32 0, metadata !395, null}
!1971 = metadata !{i32 899, i32 0, metadata !395, null}
!1972 = metadata !{i32 902, i32 0, metadata !1973, null}
!1973 = metadata !{i32 786443, metadata !1, metadata !395, i32 902, i32 0, i32 262} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1974 = metadata !{i32 903, i32 0, metadata !1973, null}
!1975 = metadata !{i32 907, i32 0, metadata !411, null}
!1976 = metadata !{i32 905, i32 0, metadata !395, null}
!1977 = metadata !{i32 911, i32 0, metadata !410, null}
!1978 = metadata !{i32 912, i32 0, metadata !1979, null}
!1979 = metadata !{i32 786443, metadata !1, metadata !410, i32 912, i32 0, i32 265} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1980 = metadata !{i32 913, i32 0, metadata !1981, null}
!1981 = metadata !{i32 786443, metadata !1, metadata !1979, i32 913, i32 0, i32 266} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1982 = metadata !{i32 915, i32 0, metadata !1981, null}
!1983 = metadata !{i32 920, i32 0, metadata !1984, null}
!1984 = metadata !{i32 786443, metadata !1, metadata !410, i32 920, i32 0, i32 267} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1985 = metadata !{i32 922, i32 0, metadata !1986, null}
!1986 = metadata !{i32 786443, metadata !1, metadata !1987, i32 922, i32 0, i32 270} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1987 = metadata !{i32 786443, metadata !1, metadata !1988, i32 922, i32 0, i32 269} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1988 = metadata !{i32 786443, metadata !1, metadata !1984, i32 921, i32 0, i32 268} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1989 = metadata !{i32 923, i32 0, metadata !1988, null}
!1990 = metadata !{i32 924, i32 0, metadata !1991, null}
!1991 = metadata !{i32 786443, metadata !1, metadata !1992, i32 924, i32 0, i32 272} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1992 = metadata !{i32 786443, metadata !1, metadata !1988, i32 924, i32 0, i32 271} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!1993 = metadata !{i32 925, i32 0, metadata !1988, null}
!1994 = metadata !{i32 10}
!1995 = metadata !{i32 786689, metadata !269, metadata !"__c", metadata !271, i32 16777305, metadata !51, i32 0, metadata !1993} ; [ DW_TAG_arg_variable ] [__c] [line 89]
!1996 = metadata !{i32 89, i32 0, metadata !269, metadata !1993}
!1997 = metadata !{i32 786689, metadata !269, metadata !"__stream", metadata !271, i32 33554521, metadata !76, i32 0, metadata !1993} ; [ DW_TAG_arg_variable ] [__stream] [line 89]
!1998 = metadata !{i32 91, i32 0, metadata !1524, metadata !1993}
!1999 = metadata !{i32 928, i32 0, metadata !410, null}
!2000 = metadata !{i32 930, i32 0, metadata !409, null}
!2001 = metadata !{i32 931, i32 0, metadata !409, null}
!2002 = metadata !{i32 932, i32 0, metadata !409, null}
!2003 = metadata !{i32 933, i32 0, metadata !409, null}
!2004 = metadata !{i32 937, i32 0, metadata !416, null}
!2005 = metadata !{i32 940, i32 0, metadata !414, null}
!2006 = metadata !{i32 942, i32 0, metadata !413, null}
!2007 = metadata !{i32 943, i32 0, metadata !413, null}
!2008 = metadata !{i32 944, i32 0, metadata !2009, null}
!2009 = metadata !{i32 786443, metadata !1, metadata !413, i32 944, i32 0, i32 278} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!2010 = metadata !{i32 945, i32 0, metadata !2009, null}
!2011 = metadata !{i32 946, i32 0, metadata !413, null}
!2012 = metadata !{i32 948, i32 0, metadata !415, null}
!2013 = metadata !{i32 951, i32 0, metadata !415, null}
!2014 = metadata !{i32 952, i32 0, metadata !415, null}
!2015 = metadata !{i32 954, i32 0, metadata !2016, null}
!2016 = metadata !{i32 786443, metadata !1, metadata !416, i32 954, i32 0, i32 279} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/main.c]
!2017 = metadata !{i32 955, i32 0, metadata !2016, null}
!2018 = metadata !{i32 957, i32 0, metadata !395, null}
!2019 = metadata !{i32 959, i32 0, metadata !395, null}
!2020 = metadata !{i32 230, i32 0, metadata !528, null}
!2021 = metadata !{i32 232, i32 0, metadata !528, null}
!2022 = metadata !{i32 239, i32 0, metadata !527, null}
!2023 = metadata !{i32 241, i32 0, metadata !527, null}
!2024 = metadata !{i32 247, i32 0, metadata !526, null}
!2025 = metadata !{i32 248, i32 0, metadata !526, null}
!2026 = metadata !{i32 250, i32 0, metadata !526, null}
