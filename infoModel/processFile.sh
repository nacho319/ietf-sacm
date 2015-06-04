#!/opt/local/bin/fish
#
# assumes an install of kramdown-rfc2629
#     gem install kramdown-rfc2629
#
# and that you have xml2rfc installed
#
#

kramdown-rfc2629 draft-inacio-sacmInfoModel-00.md  > draft-inacio-sacmInfoModel-00.xml
xml2rfc -c ~/tmp/IETF-work/XML-xref/  draft-inacio-sacmInfoModel-00.xml 

