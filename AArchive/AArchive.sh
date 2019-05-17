
#!/bin/bash(建立.sh时自动生成)

# AppleID
username="dayshy1986@outlook.com"
# 密码
password="dengxiao5945Deng"
# target名称
scheme="AutoArchive"
# 项目名
project_name="AutoArchive"
# 此处为相对路径
workspace="../${project_name}.xcworkspace"
# 打包类型
config="Release"
# 支持的sdk
sdk="iphoneos"
# 打包开始时间 
archive_start_time=$(date "+%Y-%m-%d %H-%M-%S")
# 打包文件路径
archive_root_path="${scheme}/${archive_start_time}"
# xcarchive文件路径
archive_path="${archive_root_path}/xcarchive/${scheme}.xcarchive"
# ipa文件路径
ipa_path="${archive_root_path}/ipa"
# ipa hoc 文件路径
ipa_path_hoc="${archive_root_path}/ipaHoc"
# 打包配置文件路径
plist_path="ExportOptions.plist"
# hoc 打包配置文件路径
plist_path_hoc="ExportOptionsHoc.plist"


# ）清理项目
xcodebuild clean -workspace "$workspace" -scheme "$scheme" -configuration "$config"
# ）打包
xcodebuild archive -workspace "$workspace" -scheme "$scheme" -configuration "$config" -sdk "$sdk" -archivePath "$archive_path"

# xcarchive 实际是一个文件夹不是一个文件所以使用 -d 判断
if [ -d "$archive_path" ]
then
echo "构建成功......"
else
echo "构建失败......"
exit 1
fi

# ）导出ipa
xcodebuild -exportArchive -archivePath "$archive_path" -exportPath "$ipa_path" -exportOptionsPlist "$plist_path" -allowProvisioningUpdates

if [ -f "$ipa_path/${scheme}.ipa" ]
then
echo "导出ipa成功......"
else
echo "导出ipa失败......"
exit 1
fi


# ）导出ipa hoc
xcodebuild -exportArchive -archivePath "$archive_path" -exportPath "$ipa_path_hoc" -exportOptionsPlist "$plist_path_hoc" -allowProvisioningUpdates

if [ -f "$ipa_path_hoc/${scheme}.ipa" ]
then
echo "导出ipa hoc成功......"
else
echo "导出ipa hoc失败......"
exit 1
fi

# 打包结束时间 
archive_end_time=$(date "+%Y-%m-%d %H-%M-%S")

exit 1
# ）上传App Store
# Application Loader路径
#altoolPath="/Applications/Xcode.app/Contents/Applications/Application Loader.app/Contents/Frameworks/ITunesSoftwareService.framework/Versions/A/Support/altool"
altoolPath="/Documents/Xcode/Xcode.app/Contents/Applications/Application Loader.app/Contents/Frameworks/ITunesSoftwareService.framework/Versions/A/Support/altool"

# 上传开始时间
upload_start_time=$(date "+%Y-%m-%d %H-%M-%S")

# 判断
echo "准备上传......"
"${altoolPath}" --validate-app -f "$ipa_path/${scheme}.ipa" -u "$username" -p "$password" --output-format xml
# 上传
echo "正在上传......"
"${altoolPath}" --upload-app -f "$ipa_path/${scheme}.ipa" -u "$username" -p "$password" --output-format xml

if [ $? = 0 ]
then
echo "~~~~~~~~~~~~~~~~上传成功~~~~~~~~~~~~~~~~~~~"

# 上传结束时间
upload_end_time=$(date "+%Y-%m-%d %H-%M-%S")


else
echo "~~~~~~~~~~~~~~~~上传失败~~~~~~~~~~~~~~~~~~~"
fi

echo "打包开始时间 ${archive_start_time}"
echo "打包结束时间 ${archive_end_time}"
echo "上传开始时间 ${upload_start_time}"
echo "上传结束时间 ${upload_end_time}"
