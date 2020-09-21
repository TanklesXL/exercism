#[derive(Debug, PartialEq)]
pub enum Comparison {
    Equal,
    Sublist,
    Superlist,
    Unequal,
}

pub fn sublist<T: PartialEq>(first_list: &[T], second_list: &[T]) -> Comparison {
    let is_sublist = |little_list: &[T], big_list: &[T]| match little_list.len() {
        0 => true,
        a => big_list.windows(a).any(|window| window == little_list),
    };

    match (first_list.len(), second_list.len()) {
        (a, b) if a == b && first_list == second_list => Comparison::Equal,
        (a, b) if a < b && is_sublist(first_list, second_list) => Comparison::Sublist,
        (a, b) if a > b && is_sublist(second_list, first_list) => Comparison::Superlist,
        _ => Comparison::Unequal,
    }
}
