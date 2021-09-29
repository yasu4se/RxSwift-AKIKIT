//
//  WikiViewController.swift
//  WikiRxSwiftHelloWorld
//
//  Created by yasushi saitoh on 2021/09/26.
//

import UIKit
import RxSwift
import RxCocoa

class WikiViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    // Observableの登録解除用
    private let disposeBag = DisposeBag()
    static var appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()

        // UISearchBarの入力を検知してWikiのAPIをコール
        self.searchBar.rx.text.orEmpty
                .flatMapLatest { WikiRequest(query: $0).rx_send() }
                .map { $0.query?.search ?? [] }
                // APIのレスポンスとUITableViewをバインド
                // Identifierで設定した"Cell"でUITableViewCellを使いまわし
                .bind(to: self.tableView.rx.items(cellIdentifier: "Cell")) {
                    // 検索結果のタイトルとURLを表示に反映
                    $2.textLabel?.text = $1.title
                    $2.detailTextLabel?.text = "https://ja.wikipedia.org/w/index.php?curid=\($1.pageid)"
        }
        .disposed(by: self.disposeBag)
    }
}

extension WikiViewController {

    // 画面遷移させるメソッド
    static func startVC()-> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let startVC = storyboard.instantiateInitialViewController()!
        return startVC
    }
}
