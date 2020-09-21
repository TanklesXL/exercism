#[derive(Debug, PartialEq)]
pub enum Comparison {
    Equal,
    Sublist,
    Superlist,
    Unequal,
}

pub fn sublist<T: PartialEq>(first_list: &[T], second_list: &[T]) -> Comparison {
    let is_sublist = |little_list: &[T], big_list: &[T]| {
        big_list
            .windows(little_list.len())
            .any(|window| window == little_list)
    };

    match (first_list.len(), second_list.len()) {
        (a, b) if a < b && (a == 0 || is_sublist(first_list, second_list)) => Comparison::Sublist,
        (a, b) if a > b && (b == 0 || is_sublist(second_list, first_list)) => Comparison::Superlist,
        (a, b) if a == b && first_list == second_list => Comparison::Equal,
        (_, _) => Comparison::Unequal,
    }
}
