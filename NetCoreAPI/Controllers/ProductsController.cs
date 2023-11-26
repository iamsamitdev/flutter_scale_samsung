using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using NetCoreSupalaiAPI.Data;
using NetCoreSupalaiAPI.Models;

namespace NetCoreSupalaiAPI.Controllers;

[Authorize]
[ApiController]
[Route("api/[controller]")]

public class ProductsController : ControllerBase
{
    private readonly ApplicationDbContext _context;

    public ProductsController(ApplicationDbContext context)
    {
        _context = context;
    }

    // Read all products
    [HttpGet]
    public ActionResult<Product> GetProducts()
    {
        // LINQ
        // แบบอ่านทั้งหมด เรียงตาม ProductID จากมากไปน้อย
        var allProducts = _context.Products.ToList().OrderByDescending(p => p.ProductID);

        // แบบอ่านที่มีเงื่อนไข
        // var products = _context.Products.Where(p => p.UnitPrice > 100).ToList();

        return Ok(allProducts);
    }

    // Read product by id
    [HttpGet("{id}")]
    public ActionResult<Product> GetProduct(int id)
    {
        var product = _context.Products.FirstOrDefault(p => p.ProductID == id);

        if (product == null)
        {
            return NotFound();
        }

        return Ok(product);
    }

    // Create new Product
    [HttpPost]
    public ActionResult CreateProduct(Product product)
    {
        _context.Products.Add(product);
        _context.SaveChanges();
        return Ok(product.ProductID);
    }

    // Update Product
    [HttpPut("{id}")]
    public ActionResult Update(Product product, int id)
    {
        var productToUpdate = _context.Products.Where(p => p.ProductID == id).FirstOrDefault();

        if (productToUpdate == null)
        {
            return NotFound();
        }

        _context.Products.Attach(productToUpdate);

        productToUpdate.ProductName = product.ProductName;
        productToUpdate.UnitPrice = product.UnitPrice;
        productToUpdate.UnitInStock = product.UnitInStock;
        productToUpdate.CategoryID = product.CategoryID;
        productToUpdate.ProductPicture = product.ProductPicture;

        _context.Entry(productToUpdate).State = Microsoft.EntityFrameworkCore.EntityState.Modified;

        _context.SaveChanges();

        return Ok(product);
    }

    // Delete Product
    [HttpDelete("{id}")]
    public ActionResult Delete(int id)
    {
        var productToDelete = _context.Products.Where(p => p.ProductID == id).FirstOrDefault();
        if (productToDelete == null)
        {
            return NotFound();
        }

        _context.Products.Remove(productToDelete);
        _context.SaveChanges();
        return NoContent();
    }

}