package vn.hoidanit.laptopshop.controller.admin;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;

import vn.hoidanit.laptopshop.domain.Product;
import vn.hoidanit.laptopshop.service.ProductService;
import vn.hoidanit.laptopshop.service.UploadService;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import jakarta.validation.Valid;

import org.springframework.web.bind.annotation.PostMapping;





@Controller
public class ProductController {

    private final ProductService productService;
    private final UploadService uploadService;

    public ProductController(ProductService productService, UploadService uploadService) {
        this.productService = productService;
        this.uploadService = uploadService;
    }


    @GetMapping("/admin/product")
    public String getProduct(Model model){
        List<Product> listProducts = this.productService.findAllProducts();
        model.addAttribute("listProducts", listProducts);

        return "admin/product/show";
    }

    @GetMapping("/admin/product/{id}")
    public String getProductDetailPage(Model model, @PathVariable long id){
        Product product = this.productService.findById(id);

        model.addAttribute("product", product);

        return "admin/product/detail";
    }

    @GetMapping("/admin/product/create")
    public String getCreateProductPage(Model model) {
        model.addAttribute("newProduct", new Product());

        return "admin/product/create";
    }

    @PostMapping("/admin/product/create")
    public String createProductPage(Model model, 
        @ModelAttribute("newProduct") @Valid Product newProduct,
        BindingResult newProductBindingResult,
        @RequestParam("imageFile") MultipartFile file) {
        
        List<FieldError> errors = newProductBindingResult.getFieldErrors();
        for (FieldError error : errors ) {
            System.out.println (">>>>>>>>>>" + error.getField() + " - " + error.getDefaultMessage());
        }

        // validate
        if(newProductBindingResult.hasErrors()){
            return "/admin/product/create";
        }
        return "redirect:/admin/product";
    }

    @GetMapping("/admin/product/update/{id}")
    public String getUpdateProductPage(Model model, @PathVariable long id) {
        Product currentProduct = this.productService.findById(id);

        model.addAttribute("newProduct", currentProduct);

        return "admin/product/update";
    }

    @PostMapping("/admin/product/update")
    public String updateProductPage(Model model, 
        @ModelAttribute("newProduct") Product newProduct,
        @RequestParam("imageFile") MultipartFile file) {
        
        

        // if(newProduct != null){
        //     Product currentProduct = this.productService.findById(newProduct.getId());

        //     if(!file.isEmpty()){
        //         String img = this.uploadService.handleSaveUploadFile(file, "");
        //     }
        // }
        
        return "redirect:/admin/product";
    }

    @GetMapping("/admin/product/delete/{id}")
    public String getProductDeletePage(Model model, @PathVariable long id) {
        model.addAttribute("id", id);
        model.addAttribute("newProduct", new Product());
        return "admin/product/delete";
    }

    @GetMapping("/admin/product/delete")
    public String deleteProductPage(Model model, @PathVariable long id) {
        this.productService.deleteById(id);
        return "redirect:/admin/product";
    }
    
    
}
