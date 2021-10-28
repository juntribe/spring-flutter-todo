package com.spring.todo;

import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/Item")
public class ItemController {

    private final ItemRepository repository;

    @GetMapping
    public List<Item> getItem(){
        return repository.findAll();
    }

    @PostMapping("/add")
    public Item addItem(@Validated @RequestBody Item item){
        return repository.save(item);
    }

    @PutMapping("/update/{id}")
    public ResponseEntity updateItem(@PathVariable Long id){
        boolean exist = repository.existsById(id);
        if (exist){
            Item item = repository.getById(id);
            boolean done = item.isDone();
            item.setDone(!done);
            repository.save(item);
            return new ResponseEntity<>("Item is updated", HttpStatus.OK);
        }
        return new ResponseEntity("Item is not exist", HttpStatus.BAD_REQUEST);
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity deleteTask(@PathVariable Long id){
        boolean exist = repository.existsById(id);
        if (exist){
            repository.deleteById(id);
            return new ResponseEntity("Item is deleted",HttpStatus.OK);
        }
        return new ResponseEntity("Item is not exist",HttpStatus.BAD_REQUEST);
    }

}
