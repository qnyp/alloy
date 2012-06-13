# ロギングモジュール
Logging =
  # デバッグログ出力の制御
  DEBUG_ENABLED: true

  # デバッグログを出力します。
  #
  #     @_debug('this is a debug message', someVar)
  _debug: (message, obj = null) ->
    return unless @DEBUG_ENABLED
    Ti.API.debug(message)
    Ti.API.debug(JSON.stringify(obj)) if obj isnt null

  # エラーログを出力します。
  _error: (message) ->
    Ti.API.error(message)


module.exports = Logging
