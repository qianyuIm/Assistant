//
//  AppLimitController.swift
//  Assistant
//
//  Created by cyd on 2021/11/9.
//

import UIKit
import RxTheme

class AppLimitController: AppBaseController {

    @IBOutlet weak var dataContentView: UIView!
    @IBOutlet weak var dataTitle: UILabel!
    @IBOutlet weak var dataSubtitle: UILabel!
    @IBOutlet weak var dataDescribe: UILabel!
    @IBOutlet weak var gestureContentView: UIView!
    @IBOutlet weak var gestureTitle: UILabel!
    @IBOutlet weak var gestureSubtitle: UILabel!
    @IBOutlet weak var gestureDescribe: UILabel!
    @IBOutlet weak var nameContentView: UIView!
    @IBOutlet weak var nameTitle: UILabel!
    @IBOutlet weak var nameSubtitle: UILabel!
    @IBOutlet weak var nameDescribe: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func setupUI() {
        super.setupUI()
        navigationItem.title = R.string.limit.navigationTitle.key.app.limitLocalized()
        dataTitle.text = R.string.limit.dataContentTitle.key.app.limitLocalized()
        dataSubtitle.text = R.string.limit.dataContentSubtitle.key.app.limitLocalized()
        dataDescribe.text = R.string.limit.dataDescribe.key.app.limitLocalized()
        gestureTitle.text  = R.string.limit.gestureContentTitle.key.app.limitLocalized()
        gestureSubtitle.text = R.string.limit.gestureContentSubtitle.key.app.limitLocalized()
        gestureDescribe.text = R.string.limit.gestureDescribe.key.app.limitLocalized()
        nameTitle.text  = R.string.limit.nameContentTitle.key.app.limitLocalized()
        nameSubtitle.text = R.string.limit.nameContentSubtitle.key.app.limitLocalized()
        nameDescribe.text = R.string.limit.nameDescribe.key.app.limitLocalized()
        dataContentView.app.addRoundCorners(.allCorners, radius: 6)
        gestureContentView.app.addRoundCorners(.allCorners, radius: 6)
        nameContentView.app.addRoundCorners(.allCorners, radius: 6)
    }
    override func setupTheme() {
        super.setupTheme()
        dataContentView.theme.backgroundColor = appThemeProvider.attribute({
            $0.cardTheme.color
        })
        gestureContentView.theme.backgroundColor = appThemeProvider.attribute({
            $0.cardTheme.color
        })
        nameContentView.theme.backgroundColor = appThemeProvider.attribute({
            $0.cardTheme.color
        })
        dataTitle.theme.textColor = appThemeProvider.attribute({
            $0.textTheme.titleColor
        })
        gestureTitle.theme.textColor = appThemeProvider.attribute({
            $0.textTheme.titleColor
        })
        nameTitle.theme.textColor = appThemeProvider.attribute({
            $0.textTheme.titleColor
        })
        dataSubtitle.theme.textColor = appThemeProvider.attribute({
            $0.textTheme.subtitleColor
        })
        gestureSubtitle.theme.textColor = appThemeProvider.attribute({
            $0.textTheme.subtitleColor
        })
        nameSubtitle.theme.textColor = appThemeProvider.attribute({
            $0.textTheme.subtitleColor
        })
        dataDescribe.theme.textColor = appThemeProvider.attribute({
            $0.textTheme.subtitleColor
        })
        gestureDescribe.theme.textColor = appThemeProvider.attribute({
            $0.textTheme.subtitleColor
        })
        nameDescribe.theme.textColor = appThemeProvider.attribute({
            $0.textTheme.subtitleColor
        })
    }
}
