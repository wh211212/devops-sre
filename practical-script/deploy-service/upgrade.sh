#!/bin/bash
##################################################################################################
#    Aniu Web site update script
#
#    Description:
#    - Update web site 
#    - Backup original files
#    - upload svn
#    - upgrade new web files 
##################################################################################################
#
#    CHANGELOG
#
#    History
#    2015-04-29      Bourbon.Tian    First version release for testing
#    2015-05-04      Bourbon.Tian    change case to while 
#    2015-12-11      jy              rewrite script , add help && clean part
#    2017-02-22      wanghui         add upgrade_dir
##################################################################################################

version_num=20160310

##################################################################################################
#       set variable
##################################################################################################
DATE=/bin/date
DATE_FORMAT="+%y%m%d_%H%M%S"
TIME=`date +%y%m%d%H%M%S`
upgrade_dir=/data/script
#web dir variable
web_dir=/data/www
#svn dir variable
svn_dir=/data/svnroot
#cache dir 
cache_dir1=/data/www/aniucom/myweb/Niuke/Runtime
#webback
wwwback_dir=/data/wwwback
webbck_dir=$wwwback_dir/$name_`$DATE "$DATE_FORMAT"`
#up log
date=`date +%Y%m`
upload_log=/data/script/upload
mkdir -p $upload_log/$date

##################################################################################################
#       upgrade file settings
##################################################################################################
####

#Backup original files & Upload SVN $ upgrade new web files

upgrade() {
#####
  sed -i 's/ /\//g' $upgrade_dir/upload.txt
  sed -r -i 's/(.*)(\/)(.)/\1 \3/' $upgrade_dir/upload.txt
  #back dir variable

  echo "############################################"
  echo "start upgrade"
  echo ""
#  read -p "please input the name who want to upgrade:" name

  if [ ! -d $webbck_dir ];then
        mkdir -p $webbck_dir
 fi

  while read line
    do
      dir=`echo $line | awk '{print $1}'`
      file=`echo $line | awk '{print $2}'`
      echo "backup $web_dir/$dir/$file"
     `cp -rp $web_dir/$dir/$file $webbck_dir`
     `sleep 2`
     `svn update $svn_dir/$dir/$file`
     `sleep 2`
      echo "upgrade $svn_dir/$dir/$file"
     `cp -rf $svn_dir/$dir/$file $web_dir/$dir/`
    done < $upgrade_dir/upload.txt

  mv upload.txt $upload_log/$date/upload.txt.$TIME
  echo "mv $upgrade_dir/upload.txt $upload_log/$date/upload.txt.$TIME"
  echo ""
  echo "finished upgrade"
  echo "############################################"
}

clean_cache () {
  echo "############################################"
  echo "start clean cache"
  echo ""
  echo "cache dir is $cache_dir1"
  rm -rf /data/www/aniucom/myweb/Niuke/Runtime*
  echo ""
  echo "finished clean cache"
  echo "############################################"
}
#################################################################################################
# Script common functions
#################################################################################################

help() {
  print_version
  printf "Usage: %s: [-h] [-v] [-t] [-a] args" $(basename $0)
  printf "\n
  -h -- display help (this page)
  -v -- display version
  -c -- clean the cache
  -u -- upgrade files in upload.txt\n\n"
}

# display version number
print_version() {
  printf "Version: %s\n" $version_num
}
# get options to play with and define the script behavior
get_options() {
  while getopts 'hvcu' OPTION;
  do
    case "$OPTION" in
      h)    help
                exit 0
                ;;
      v)    print_version
                exit 0
                ;;
      c)    clean_cache
                ;;
      u)    upgrade
                ;;
      ?)    help >&2
                exit 2
                ;;
    esac
    # if a parameter entered by the user is '-'
    if [ -z "$OPTION" ]; then
    echo -e "$RED ERROR: Invalid option entered $NO_COLOR" >&2
      help >&2
      exit 2
    fi
  done
}

# check that at least one parameter has been added when lauching the script
if [ -z "$@" ]; then
  help >&2
  exit 2
fi

parameter=`echo "$@" | awk '{print substr($0,0,1)}'`
if [ "$parameter" != "-" ]; then
  help >&2
  exit 2
fi

# get options
get_options "$@"
