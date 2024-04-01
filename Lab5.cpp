#include <iostream>
#include <climits>

struct Drink;

void InvalidInput();
void AddMoney(const int amountToAdd, int& moneyCount);
void InputMoney();
void Admin();
void Refund(int& moneyCount);
void SelectDrink(int& moneyCount);
void BuyDrink(Drink& drink, int& moneyCount);
void Exit();

struct Drink
{
    const char* name;
    int amountLeft = 2;
};

Drink Coke = {.name="Coke"};
Drink Sprite = {.name="Sprite"};
Drink DrPepper = {.name="Dr. Pepper"};
Drink CokeZero = {.name="Coke Zero"};

int main(void)
{

    printf("Welcome to the vending machine. All Drinks cost 55 cents.\n");

    InputMoney();

    return 0;
}

void InputMoney()
{
    int moneyCount = 0;
    char inputOption = '\0';

    while(true)
    {
        if(Coke.amountLeft <= 0 && Sprite.amountLeft <= 0 && DrPepper.amountLeft <= 0 && CokeZero.amountLeft <= 0) {Exit();}
        if(moneyCount >= 55) {SelectDrink(moneyCount);}

        printf("Please enter money or the secret password (L).\n\nYou may enter money in the form of nickels (N), dimes (D), quarters (Q), or dollar bills (B), or you may exit the machine with a refund (X).\n\n");
        std::cin >> inputOption;
        switch (inputOption)
        {
            case 'L':
                Admin();
                break;
            case 'N':
                AddMoney(5, moneyCount);
                break;
            case 'D':
                AddMoney(10, moneyCount);
                break;
            case 'Q':
                AddMoney(25, moneyCount);
                break;
            case 'B':
                AddMoney(100, moneyCount);
                break;
            case 'X':
                Refund(moneyCount);
                break;
            default:
                InvalidInput();
                break;
        }
    }
}

void SelectDrink(int& moneyCount)
{
    char inputOption = '\0';

    while(true)
    {
        printf("You may select a drink of Coke (C), Sprite (S), Dr. Pepper (P), Coke Zero (Z), or you may exit the machine with a refund (X).\n\n");
        std::cin >> inputOption;

        switch (inputOption)
        {
        case 'C':
            BuyDrink(Coke, moneyCount);
            break;
        case 'S':
            BuyDrink(Sprite, moneyCount);
            break;
        case 'P':
            BuyDrink(DrPepper, moneyCount);
            break;
        case 'Z':
            BuyDrink(CokeZero, moneyCount);
            break;
        case 'X':
            Refund(moneyCount);
            InputMoney();
            break;
        default:
            InvalidInput();
            break;
        }
    }
}

void BuyDrink(Drink& drink, int& moneyCount)
{
    if(drink.amountLeft <= 0) 
    {
        printf("Sorry we are out of %s please choose another option\n", drink.name);
        SelectDrink(moneyCount);
    }
    printf("You have bought a %s and have recived %d cents as change.\n", drink.name, moneyCount-55);
    drink.amountLeft--;
    moneyCount = 0;
    InputMoney();
}

void AddMoney(const int amountToAdd, int& moneyCount)
{
    moneyCount += amountToAdd;

    printf("You entered %d cents and the total is now %d cents.\n\n\n", amountToAdd, moneyCount);
}

void Refund(int& moneyCount)
{
    printf("You have recived %d cents back.\n\n\n", moneyCount);
    moneyCount = 0;
}

void Admin()
{
    printf("There are %d Coke(s), %d Sprite(s), %d Dr. Pepper(s), and %d Coke Zero(s) left.\n", Coke.amountLeft, Sprite.amountLeft, DrPepper.amountLeft, CokeZero.amountLeft);
}

void Exit()
{
    printf("The machine is out of drinks and will shutdown now.\n");
    exit(0);
}

void InvalidInput()
{
    std::cin.clear();
    std::cin.ignore(INT_MAX, '\n');
    printf("Please enter a valid input.\n");
}