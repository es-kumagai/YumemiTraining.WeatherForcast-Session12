# iOS研修
業務に近いかたちでアプリ開発を行いながら、  
iOSアプリ開発の基礎復習、実務スキルを身に付けるための研修です。

## 概要
1〜6までの課題をクリアし、天気予報アプリを開発していただきます。  
課題の回答例は現在作成中 ~~`T.B.D`にあります。~~

## 環境
Xcode 11.4  
Swift 5.2

## 天気予報API
`YumemiWeather`というライブラリを使用してください。  
SwiftPackageManagerに対応しています。

インストール方法やAPI仕様は以下を参照ください。  
[YumemiWeather](Documentation/YumemiWeather.md)

## 研修の進め方
1. v1.0.0のタグから自身のdevelopブランチを作成  
ブランチ名: `{name}/develop`
1. リポジトリのルートにXcodeProjectを作成  
`ios-training/{name}/{name}.xcodeproj`
1. XcodeProjectに[YumemiWeather](Documentation/YumemiWeather.md)を導入
1. `{name}/develop`ブランチをPush
1. 課題用のブランチを切って実施  
`{name}/session/{#}`
1. 完了したらPull Requestを作成し、レビュー依頼  
`{name}/develop` <-- `{name}/session/{#}`  
Reviewersは `yumemi/yutu`
1. Approvalされたらマージ
1. 回答例がある場合は目を通してみる
1. 次の課題を実施

全ての改題をクリアしたら修了です！


# 課題
- [Session1](Documentation/Session1.md)
- [Session2](Documentation/Session2.md)
- [Session3](Documentation/Session3.md)
- [Session4](Documentation/Session4.md)
- [Session5](Documentation/Session5.md)
- [Session6](Documentation/Session6.md)
- [Session7](Documentation/Session7.md)
- [Session8](Documentation/Session8.md)