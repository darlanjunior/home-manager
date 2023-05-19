import { integer, varchar, pgEnum, timestamp, text, pgTable, doublePrecision } from "drizzle-orm/pg-core";
import { defaultColumns } from "./utils";

export const households = pgTable('households', {
  ...defaultColumns,
  name: varchar('name', { length: 100 }).notNull(),
  picture: varchar('picture', { length: 200 }),
})

export const users = pgTable('users', {
  ...defaultColumns,
  name: varchar('name', { length: 100 }).notNull(),
  picture: varchar('picture', { length: 200 }),
  weightGoal: integer('weight_goal'),
  height: integer('height'),
  // birthGender: pgEnum('genders', ['male', 'female'])('birth_gender'),
  caloriesGoal: integer('calories_goal'),
  email: varchar('email', { length: 100 }).notNull(),
  password: varchar('password', { length: 100 }).notNull()
})

export const householdInvites = pgTable('household_invites', {
  ...defaultColumns,
  email: varchar('email', { length: 100 }).notNull(),
  sentAt: timestamp('sent_at').defaultNow().notNull(),
  user: integer('user').references(() => users.id)
})

export const householdUsers = pgTable('household_users', {
  ...defaultColumns,
  user: integer('user').references(() => users.id).notNull(),
  household: integer('household').references(() => households.id).notNull()
})

export const ingredients = pgTable('ingredients', {
  ...defaultColumns,
  name: varchar('name', { length: 100 }).notNull(),
  calories: integer('calories').notNull(),
  density: integer('density').notNull(),
  unitWeight: integer('unit_weight').notNull(),
  protein: integer('protein').notNull(),
  sugar: integer('sugar').notNull(),
  fat: integer('fat').notNull(),
})

export const recipes = pgTable('recipes', {
  ...defaultColumns,
  name: varchar('name', { length: 100 }).notNull(),
  description: text('description'),
  steps: text('steps'),
  household: integer('household').references(() => households.id).notNull()
})

export const recipeIngredients = pgTable('recipe_ingredients', {
  recipe: integer('recipe').references(() => recipes.id).notNull(),
  ingredient: integer('ingredient').references(() => ingredients.id).notNull(),
  weightAmount: integer('weight_amount'),
  litersAmount: integer('liters_amount'),
  amount: integer('amount')
})

export const meals = pgTable('meals', {
  ...defaultColumns,
  recipe: integer('recipe').references(() => recipes.id).notNull(),
  multiplier: doublePrecision('multiplier')
})

export const storageItems = pgTable('storage_items', {
  household: integer('household').references(() => households.id).notNull(),
  ingredient: integer('ingredient').references(() => ingredients.id).notNull(),
  weightAmount: integer('weight_amount'),
  litersAmount: integer('liters_amount'),
  amount: integer('amount')
})