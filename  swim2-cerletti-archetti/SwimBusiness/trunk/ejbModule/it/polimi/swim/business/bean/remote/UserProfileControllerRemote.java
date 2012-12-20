package it.polimi.swim.business.bean.remote;

import it.polimi.swim.business.entity.Customer;
import it.polimi.swim.business.entity.Friendship;

import java.util.List;

import javax.ejb.Remote;

@Remote
public interface UserProfileControllerRemote {
	public List<Customer> getFriendList();
	public List<Friendship> getFriendshipRequest();
}