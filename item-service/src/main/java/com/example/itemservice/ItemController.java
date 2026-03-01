package com.example.itemservice;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/items")
public class ItemController {

    // Simple in-memory list (no database needed)
    private List<Map<String, Object>> items = new ArrayList<>();
    private int idCounter = 1;

    public ItemController() {
        // Initialize with default items
        items.add(createItem("Book"));
        items.add(createItem("Laptop"));
        items.add(createItem("Phone"));
    }

    private Map<String, Object> createItem(String name) {
        Map<String, Object> item = new java.util.HashMap<>();
        item.put("id", idCounter++);
        item.put("name", name);
        return item;
    }

    @GetMapping({"", "/"})
    public List<Map<String, Object>> getItems() {
        return items;
    }

    @PostMapping({"", "/"})
    public ResponseEntity<Map<String, Object>> addItem(@RequestBody Map<String, Object> itemData) {
        String name = (String) itemData.get("name");
        Map<String, Object> newItem = createItem(name);
        items.add(newItem);
        return ResponseEntity.status(HttpStatus.CREATED).body(newItem);
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getItem(@PathVariable int id) {
        return items.stream()
                .filter(item -> item.get("id").equals(id))
                .findFirst()
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }
}
