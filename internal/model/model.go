package model

import "fmt"

type BaseObject struct {
	id   int    //Not Exported Lower Case
	Name string // Exported Upper case
}

func (b *BaseObject) Id() int {
	return b.id
}

type Dogs struct {
	BaseObject
	Age string
}

func (dog *Dogs) Talk() string {
	return "Woof Wof"
}

type Cats struct {
	BaseObject
	Age string
}

func (cat *Cats) Talk() string {
	return "Woof Wof"
}

type Animal interface {
	Talk()
}

type User struct {
	BaseObject
	pets []Animal
}

func (a *Animal) FindOwner() User {
	aid := a.Id()
	fmt.Println(aid)
	return User{}
}
