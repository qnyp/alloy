Module = require('common/Module')
Logging = require('common/Logging')

# ウィンドウベースクラス
class BaseWindow extends Module
  @include Logging

  __parentWindow: null

  # コンストラクタ
  # @param parentWindow [Ti.UI.Window, null]
  # @param params [Object]
  constructor: (parentWindow, params = {}) ->
    @_debug('constructor', params)
    @__parentWindow = parentWindow
    @initializeModels(params)
    @_debug('models initialized')
    @initializeViews(params)
    @_debug('views initialized')
    @initializeEvents(params)
    @_debug('events initialized')

  # モデルの初期化
  # @param params [Object]
  initializeModels: (params) ->
    @_debug('please override initializeModels')

  # ビューの初期化
  initializeViews: (params) ->
    @_debug('please override initializeViews')

  # イベントの初期化
  initializeEvents: (params) ->
    @_debug('please override initializeEvents')

  # 親ウィンドウを返す
  getParentWindow: (params) -> @__parentWindow

module.exports = BaseWindow
