exports.Styles =

  theme:
    black: '#000'
    gray: '#666666'
    white: '#fff'
    titlebackgroundGradient:
      type: 'linear',
      startPoint: { x: '50%', y: '0%' },
      endPoint: { x: '50%', y: '100%' },
      colors: [
        { color: '#811d29', offset: 0.0},
        { color: '#c52a38', offset: 1.0 }
      ]
    baseColor: '#27313b'
    ratingColor: "#f76913"
    checkinColor: "#5bae2e"
    reviewColor: "#2788c7"
    genreColor: "#848484"
    checkinTitleColor: "#e6492d"
    checkinCommentColor: "#656565"
    window:
      backgroundColor: '#000'
      barColor: '#27323b'
      barImage: '/images/tab_icons/navi_bg.png',
    tableView:
      backgroundColor: '#ffffff'
      separatorStyle: Ti.UI.iPhone.TableViewSeparatorStyle.NONE
      backgroundRepeat: true
      top:0
      bottom:0
    borderedTableView:
      backgroundColor: '#ffffff'
      backgroundRepeat: true
      top:0
      bottom:0
    tableViewRow:
      selectedBackgroundColor: '#fbcfcf'
    tableViewRowTouchDisable:
      touchEnabled: false
      selectionStyle:Titanium.UI.iPhone.TableViewCellSelectionStyle.NONE
    tableViewHeader:
      backgroundColor: '#c3939f'
      color: '#ffffff'
    tableViewFooter:
      backgroundColor: '#c3939f'
      color: '#ffffff'
    searchButton:
      title: L('searchWindowButton')
      backgroundImage: '/images/button.png'
      backgroundSelectedImage: '/images/backgroundSelectedImage.png'
      width: 250
      height: 44
      top: 10
      bottom: 30
      color: "#ffffff"
      font: { fontSize: 18, fontWeight: 'bold' }
    tabbedBar:
      backgroundColor: '#27323b'
    searchBar:
      barColor: '#27323b'
    userImage:
      height: 40
      width: 40
      defaultImage:'/images/user_no_image.png'
      hires: true
    userImageForUpdate:
      height: 100
      width: 100
      defaultImage:'/images/user_no_image.png'
      hires: true

  properties:
    SampleWindow:
      backgroundColor: '#fff'
      title: L('SampleWindowTitle')

