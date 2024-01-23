//
//  ViewController.swift
//  ExDataSource
//
//  Created by 김종권 on 2024/01/23.
//

import UIKit

// before

//class ViewController: UIViewController {
//
//    struct Section {
//        var title: String
//        var items: [String]
//    }
//
//    var sections: [Section] = [
//        Section(title: "header is a", items: ["A1", "A2"]),
//        Section(title: "header is b", items: ["B1", "B2"]),
//    ]
//
//    let tableView: UITableView = {
//        let tableView = UITableView()
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        return tableView
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        tableView.dataSource = self
//
//        view.addSubview(tableView)
//
//        NSLayoutConstraint.activate([
//            tableView.topAnchor.constraint(equalTo: view.topAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
//        ])
//    }
//}
//
//extension ViewController: UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        sections.count
//    }
//
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        sections[section].title
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        sections[section].items.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = sections[indexPath.section].items[indexPath.row]
//        return cell
//    }
//}

// refactor

class ViewController: UIViewController {
    enum Section: Int, CaseIterable {
        case a
        case b
        
        var headerTitle: String {
            switch self {
            case .a:
                "header is a"
            case .b:
                "header is b"
            }
        }
    }
    enum Item: String {
        case A1
        case A2
        case B1
        case B2
    }
    
    var dataSource: [Section: [Item]] = [
        .a: [.A1, .A2],
        .b: [.B1, .B2],
    ]

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self

        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        dataSource.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items(section: section).count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        Section(rawValue: section)?.headerTitle
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let items = items(section: indexPath.section)
        let item = items[indexPath.item]
        cell.textLabel?.text = item.rawValue
        return cell
    }
    
    private func items(section index: Int) -> [Item] {
        dataSource[Section(rawValue: index) ?? .a] ?? []
    }
}
