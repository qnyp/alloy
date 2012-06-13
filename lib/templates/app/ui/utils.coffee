# UIユーティリティ
#
# utils = require('ui/utils')
# contentView = utils.createContentView()
# window = utils.createWindow(contentView, {})
# window.add(someView)

STATUSBAR_HEIGHT = 20
NAVBAR_HEIGHT = 44
SEARCHBAR_HEIGHT = 44
TABGROUP_HEIGHT = 49
ADVIEW_HEIGHT = 50

# コンテンツ表示領域の高さを返します
#
# @return int
getContentHeight = (showTab = false)->
  height = Ti.Platform.displayCaps.platformHeight - STATUSBAR_HEIGHT - NAVBAR_HEIGHT
  # タブを表示する場合はタブ高さを引きます
  if showTab
    height = height - TABGROUP_HEIGHT
  return height
exports.getContentHeight = getContentHeight

# 広告ビューと合わせて表示するコンテンツビューを生成して返します。
#
# @return Ti.UI.View
exports.createContentView = (showTab = false)->
  # コンテンツビューを作成
  return Ti.UI.createView
    backgroundColor: '#fff'
    top: 0
    height: getContentHeight(showTab)

# ウィンドウを生成して返します。
#
# @param params Object
# @return Ti.UI.Window
exports.createWindow = (contentView, params) ->
  # ウィンドウを作成
  win = Ti.UI.createWindow(params)

  unless Ti.App.isAndroid
    styles = require('ui/styles').Styles
    win.barColor = styles.theme.window.barColor
    win.barImage = styles.theme.window.barImage

  win.add(contentView) if contentView
  return win

# 指定されたタブで新しいウィンドウを開きます。
#
# @param tab Ti.UI.Tab
# @param nextWindow Ti.UI.Window
exports.openNextWindowInTab = (tab, nextWindow) ->
  nextWindow.window.tabBarHidden = true
  nextWindow.global.tabGroup.hide()
  nextWindow.containingTab = tab
  tab.open(nextWindow.window, { animated: true })

# エラーダイアログを表示します。
#
# @parasm String message
exports.showErrorDialog = (message)->
  Ti.UI.createAlertDialog(
      title: L('error'), message: message,
      buttonNames: [L('ok')]
  ).show()


