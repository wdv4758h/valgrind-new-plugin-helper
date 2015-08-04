#!/bin/sh

read -p "Please tell me you new Valgrind plugin's full name (e.g. memcheck): " plugin
read -p "and it's abbreviation (e.g. mc): " plugin_abbr

get_source_code () {
    # get Valgrind source code
    svn co svn://svn.valgrind.org/valgrind/trunk valgrind
}

newplugin () {
    # create new plugin's files
    mkdir -p $plugin/docs $plugin/tests
    touch $plugin/docs/Makefile.am $plugin/tests/Makefile.am
    cp none/Makefile.am $plugin/

    # replace some name
    sed -i "s/none/${plugin}/g"      $plugin/Makefile.am
    sed -i "s/NONE/${plugin^^}/g"    $plugin/Makefile.am
    sed -i "s/nl_/${plugin_abbr}_/g" $plugin/Makefile.am
    sed -i "s/nl-/${plugin_abbr}-/g" $plugin/Makefile.am

    echo "Please change the details lines in ${plugin_abbr}_main.c's ${plugin_abbr}_pre_clo_init() to something appropriate for the tool."
    echo "These fields are used in the startup message, except for bug_reports_to which is used if a tool assertion fails."
    cp none/nl_main.c $plugin/${plugin_abbr}_main.c
    sed -i "s/nl_/${plugin_abbr}_/g" $plugin/${plugin_abbr}_main.c

    sed -i "/memcheck \\\/a\		${plugin}\\" Makefile.am

    # update configure.ac
    sed -i "/coregrind\/Makefile/a\   ${plugin}\/Makefile\n   ${plugin}\/tests/Makefile\n   ${plugin}\/docs/Makefile" configure.ac
}

build () {
    ./autogen.sh
    ./configure --prefix=`pwd`/inst
    make -j8 install    #  putting copies of the tool in ${plugin}/ and inst/lib/valgrind/
}

test () {
    inst/bin/valgrind --tool=${plugin} date
}

get_source_code
cd valgrind
newplugin
build
test
