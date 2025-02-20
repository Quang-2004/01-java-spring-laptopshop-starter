package vn.hoidanit.laptopshop.controller.admin;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import vn.hoidanit.laptopshop.domain.Order;
import vn.hoidanit.laptopshop.domain.OrderDetail;
import vn.hoidanit.laptopshop.service.OrderService;




@Controller
public class OrderController {

    private final OrderService orderService;
    

    public OrderController(OrderService orderService) {
        this.orderService = orderService;
    }

    @GetMapping("/admin/order")
    public String getDashBoard(Model model,
    @RequestParam("page") Optional<String> pageOptional){

        int page = 1;
        try {
            if(pageOptional.isPresent()){
                page = Integer.parseInt(pageOptional.get());
            }
            else{
                // page = 1
            }
        } catch (Exception e) {
            // page = 1
            // TODO: handle exception
        }

        Pageable pageable = PageRequest.of(page - 1, 2);
        Page<Order> prs = this.orderService.findAll(pageable);

        List<Order> orders = prs.getContent();

        model.addAttribute("orders", orders);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", prs.getTotalPages());
        return "admin/order/show";
    }

   
    @GetMapping("/admin/order/{id}")
    public String getOrderDetailPage(Model model, @PathVariable long id){
        List<OrderDetail> orderDetails = this.orderService.findByOrder(this.orderService.findById(id));

        model.addAttribute("orderDetails", orderDetails);
        model.addAttribute("id", id);

        return "admin/order/detail";
    }

    

    @GetMapping("/admin/order/update/{id}")
    public String getUpdateOrderPage(Model model, @PathVariable long id) {
        Order order = this.orderService.findById(id);

        model.addAttribute("order", order);

        return "admin/order/update";
    }

    @PostMapping("/admin/order/update")
    public String updateProductPage(Model model, 
        @ModelAttribute("order") Order updateOrder) {

        Order currentOrder = this.orderService.findById(updateOrder.getId());
        if(currentOrder != null){

            // update
            currentOrder.setStatus(updateOrder.getStatus());

            // save order
            this.orderService.handleSaveOrder(currentOrder);
            
        }
        
        return "redirect:/admin/order";
    }

    @GetMapping("/admin/order/delete/{id}")
    public String getOrderDeletePage(Model model, @PathVariable long id) {
        model.addAttribute("id", id);
        model.addAttribute("order", new Order());
        return "admin/order/delete";
    }

    @PostMapping("/admin/order/delete")
    public String deleteOrderPage(Model model, @ModelAttribute("order") Order order) {
        this.orderService.deleteByOrder(order);
        this.orderService.deleteById(order.getId());
        return "redirect:/admin/order";
    }
}
