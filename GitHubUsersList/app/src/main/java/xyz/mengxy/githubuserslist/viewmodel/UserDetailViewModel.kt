package xyz.mengxy.githubuserslist.viewmodel

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import dagger.hilt.android.lifecycle.HiltViewModel
import xyz.mengxy.githubuserslist.model.User
import javax.inject.Inject

/**
 * Created by Mengxy on 3/30/22.
 */
@HiltViewModel
class UserDetailViewModel @Inject constructor() : ViewModel() {

    val userLiveData = MutableLiveData<User>()

    fun setUserInfo(user: User) {
        userLiveData.value = user
    }
}
