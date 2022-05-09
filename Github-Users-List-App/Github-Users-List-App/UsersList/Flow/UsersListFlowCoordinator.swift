//
//  UsersListFlowCoordinator.swift
//  GitHub-Users-List-App
//
//  Created by 邹奂霖 on 2022/5/9.
//

import Foundation
import UIKit
protocol UsersListFlowCoordinatorDependencies {
    func makeUsersListViewController(actions: UsersListViewModelActions) -> UsersListViewController

}



