let main = document.getElementById('main');
let categoryItems = document.getElementsByClassName('category__item');
let vote = document.getElementsByClassName('vote');
let productItems = document.getElementsByClassName('product__item');

//show vote panel and click then hide
Array.from(vote).forEach(element => {
    element.addEventListener('click', showVotePanel);
});
// end

for (let i = 0; i < categoryItems.length; i++) {
    categoryItems[i].onclick = function () {
        for (let i = 0; i < categoryItems.length; i++) {
            categoryItems[i].classList.remove('category__item--active');
            categoryItems[i].classList.remove('category__item--border');
        }
        categoryItems[i].classList.add('category__item--active');
        categoryItems[i].classList.add('category__item--border');
    }
}

function lowToHighPrice() {
    let newProductItems = orderIncresePrice(true);
    appendNewListProductItems(newProductItems);
}
function highToLowPrice() {
    let newProductItems = orderIncresePrice(false);
    appendNewListProductItems(newProductItems);
}

function highToLowVote() {
    let newProductItems = Array.prototype.slice.call(productItems).sort(function (item1, item2) {
        let vote1 = parseFloat(item1.children[3].innerText);
        let vote2 = parseFloat(item2.children[3].innerText);
        console.log(vote1, vote2);
        return vote2 - vote1;
    });
    appendNewListProductItems(newProductItems);
}

function orderIncresePrice(isIncrease) {
    let newProductItems = Array.prototype.slice.call(productItems).sort(function (item1, item2) {
        let price1 = parseFloat(item1.children[item1.children.length - 1].innerText);
        let price2 = parseFloat(item2.children[item2.children.length - 1].innerText);
        console.log(price1);
        return price1 - price2;
    });
    if (isIncrease)
        return newProductItems;
    else
        return newProductItems.reverse();
}
function appendNewListProductItems(newProductItems) {
    for (let productItem of newProductItems) {
        productItems[0].parentNode.appendChild(productItem);
    }
}