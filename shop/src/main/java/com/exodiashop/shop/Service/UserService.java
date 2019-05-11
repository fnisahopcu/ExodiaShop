package com.exodiashop.shop.Service;

import com.exodiashop.shop.Model.Product;
import com.exodiashop.shop.Model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Service
public class UserService {


    @Autowired
    ProductService productService;



        List<User> userList = new ArrayList<User>( Arrays.asList(
                    new User(),
                    new User(),
                    new User()
            )
    );

    public List<User> getUserList(){
        return userList;
    }

    public User getUserByUserName(String username){
        return getUserList().stream().filter(t -> t.getUsername().equals(username)).findFirst().get();
    }

        public void addUser(User user){
        userList.add(user);
    }

    public void updateUser(User user, String username){
        for (int i=0; i<userList.size(); i++) {
            if (userList.get(i).getUsername().equals(username)) {
                userList.set(i, user);
                break;
            }
        }
    }

    public void add2cart(String username, int productID){
        Product product = productService.getProductByID(productID);
        //getUserList().stream().filter(t -> t.getUsername().equals(username)).findFirst().get().getShopping_cart().add(product);
    }


    public User validateUser(String userName, String password) {

        User u = new User();
        return u;
    }



}
