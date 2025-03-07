package vn.hoidanit.laptopshop.controller.admin;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
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
    public String getProduct(Model model,
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

        Pageable pageable = PageRequest.of(page - 1, 100);
        Page<Product> prs = this.productService.findAllProducts(pageable);

        List<Product> listProducts = prs.getContent();

        model.addAttribute("products", listProducts);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", prs.getTotalPages());

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
            return "admin/product/create";
        }

        
        String image = this.uploadService.handleSaveUploadFile(file, "product");
        newProduct.setImage(image);
        this.productService.handleSaveProduct(newProduct);
        
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
        @ModelAttribute("newProduct") @Valid Product updateProduct,
        BindingResult newProductBindingResult,
        @RequestParam("imageFile") MultipartFile file) {
        
        List<FieldError> errors = newProductBindingResult.getFieldErrors();
        for (FieldError error : errors ) {
            System.out.println (">>>>>>>>>>" + error.getField() + " - " + error.getDefaultMessage());
        }

        // validate
        if(newProductBindingResult.hasErrors()){
            model.addAttribute("updateProduct", updateProduct);
            return "admin/product/update";
        }
        
        Product currentProduct = this.productService.findById(updateProduct.getId());
        if(currentProduct != null){
            
            String image = this.uploadService.handleSaveUploadFile(file, "product");
            if(image != "") currentProduct.setImage(image);

            // update
            currentProduct.setName(updateProduct.getName());;
            currentProduct.setPrice(updateProduct.getPrice());
            currentProduct.setDetailDesc(updateProduct.getDetailDesc());
            currentProduct.setShortDesc(updateProduct.getShortDesc());
            currentProduct.setQuantity(updateProduct.getQuantity());
            currentProduct.setFactory(updateProduct.getFactory());
            currentProduct.setTarget(updateProduct.getTarget());
            

            // save product
            this.productService.handleSaveProduct(currentProduct);
            
        }
        
        return "redirect:/admin/product";
    }

    @GetMapping("/admin/product/delete/{id}")
    public String getProductDeletePage(Model model, @PathVariable long id) {
        model.addAttribute("id", id);
        model.addAttribute("newProduct", new Product());
        return "admin/product/delete";
    }

    @PostMapping("/admin/product/delete")
    public String deleteProductPage(Model model, @ModelAttribute("newProduct") Product newProduct) {
        this.productService.deleteById(newProduct.getId());
        return "redirect:/admin/product";
    }

    @GetMapping("/admin/product/search")
    public String getSearchProduct(Model model,
    @RequestParam("page") Optional<String> pageOptional,
    @RequestParam("search") Optional<String> searchOptional){
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

        Pageable pageable = PageRequest.of(page - 1, 100);
        String search = searchOptional.isPresent() ? searchOptional.get() : "";
        Page<Product> prs = this.productService.findAllProductsByNameWithSpec(pageable, search);
        long quantityProducts = prs.getTotalElements();

        List<Product> listProducts = prs.getContent();

        model.addAttribute("products", listProducts);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", prs.getTotalPages());
        model.addAttribute("quantityProducts", quantityProducts);

        return "admin/product/search";
    }
    
    
}
