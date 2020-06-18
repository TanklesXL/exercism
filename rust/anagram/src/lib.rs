use std::collections::HashMap;
use std::collections::HashSet;
use unicode_segmentation::UnicodeSegmentation;
pub fn anagrams_for<'a>(word: &str, possible_anagrams: &[&'a str]) -> HashSet<&'a str> {
    let count = count_letters(word);

    possible_anagrams
        .iter()
        .copied()
        .filter(|&w| w.to_lowercase() != word.to_lowercase() && count_letters(w) == count)
        .collect::<HashSet<&'a str>>()
}

fn count_letters(word: &str) -> HashMap<String, u8> {
    let mut counts: HashMap<String, u8> = HashMap::new();
    for letter in word.graphemes(true).into_iter() {
        let letter = letter.to_lowercase();
        match counts.get(&letter) {
            Some(&num) => counts.insert(letter, num + 1),
            None => counts.insert(letter, 1),
        };
    }

    counts
}
