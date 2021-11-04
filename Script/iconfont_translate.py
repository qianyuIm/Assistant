# coding=utf-8
#!/usr/bin/python


import re
import os
import time

shellPath = os.path.split(os.path.abspath(__file__))[0]
rootPath = os.path.dirname(shellPath)
# 生成的QYIconFontIcons.swift 文件路径
generateFile = rootPath + '/Assistant/Common/AppIconFont/AppIconFontIcons.swift'
# iconfont css 文件存放路径
iconFontCss = rootPath + '/Assistant/Resources/IconFont/iconfont.css'

# 将 iconfont 的 css 自动转换为 dart 代码
def translate():
    print('Begin translate...')
    
    code = """
/// @author:  qy
/// @date: {date}
/// @description  代码由程序自动生成。请不要对此文件做任何修改。

import EFIconFont

let appIconFontIcons = EFIconFont.iconFontIcons

extension EFIconFont {

    static let iconFontIcons = AppIconFontIcons.self
}

extension AppIconFontIcons: EFIconFontCaseIterableProtocol {

    public static var name: String {
        return "iconfont"
    }

    public var unicode: String {
        return self.rawValue
    }
}


enum AppIconFontIcons: String {
        {icon_codes}
    }
""".strip()
    strings = []
    content = open(iconFontCss).read().replace('\n  content', 'content')
    matchObj = re.finditer( r'.icon_(.*?):(.|\n)*?"\\(.*?)";', content)
    for match in matchObj:
        name = match.group(1)
        string1 =  f'case {name}'
        string2 =  f'{match.group(3)}'
        string = string1 + ' = ' + '"\\u{' + string2 + '}"'
        strings.append(string)
    strings = '\n'.join(strings)
    code = code.replace('{icon_codes}', strings)
    code = code.replace('{date}', time.strftime("%Y-%m-%d %H:%M:%S", time.localtime()))
    open(generateFile, 'w').write(code)
    print('Finish translate...')

if __name__ == "__main__":
    translate()



