#![allow(clippy::needless_return)]
use std::collections::HashMap;

fn main() {
    // Create a new map.
    let mut generated_map = HashMap::new();
    // Add random key value pair to a given map.
    generated_map.insert("a", "1");
    generated_map.insert("b", "2");
    generated_map.insert("c", "3");
    // Get a list of all keys in a given map.
    println!("{:?}", get_a_list_of_all_keys_in_map(&mut generated_map));
}

// Get a list of all keys in a given map.
fn get_a_list_of_all_keys_in_map<'a>(map: &'a mut HashMap<&str, &str>) -> Vec<&'a str> {
    let mut keys: Vec<&str> = Vec::new();
    for (key, _) in map.iter() {
        keys.push(key);
    }
    return keys;
}
