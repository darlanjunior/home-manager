CREATE TABLE IF NOT EXISTS "household_invites" (
	"id" serial PRIMARY KEY NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"email" varchar(100) NOT NULL,
	"sent_at" timestamp DEFAULT now() NOT NULL,
	"user" integer
);

CREATE TABLE IF NOT EXISTS "household_users" (
	"id" serial PRIMARY KEY NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"user" integer NOT NULL,
	"household" integer NOT NULL
);

CREATE TABLE IF NOT EXISTS "households" (
	"id" serial PRIMARY KEY NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"name" varchar(100) NOT NULL,
	"picture" varchar(200)
);

CREATE TABLE IF NOT EXISTS "ingredients" (
	"id" serial PRIMARY KEY NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"name" varchar(100) NOT NULL,
	"calories" integer NOT NULL,
	"density" integer NOT NULL,
	"unit_weight" integer NOT NULL,
	"protein" integer NOT NULL,
	"sugar" integer NOT NULL,
	"fat" integer NOT NULL
);

CREATE TABLE IF NOT EXISTS "meals" (
	"id" serial PRIMARY KEY NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"recipe" integer NOT NULL,
	"multiplier" double precision
);

CREATE TABLE IF NOT EXISTS "recipe_ingredients" (
	"recipe" integer NOT NULL,
	"ingredient" integer NOT NULL,
	"weight_amount" integer,
	"liters_amount" integer,
	"amount" integer
);

CREATE TABLE IF NOT EXISTS "recipes" (
	"id" serial PRIMARY KEY NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"name" varchar(100) NOT NULL,
	"description" text,
	"steps" text,
	"household" integer NOT NULL
);

CREATE TABLE IF NOT EXISTS "storage_items" (
	"household" integer NOT NULL,
	"ingredient" integer NOT NULL,
	"weight_amount" integer,
	"liters_amount" integer,
	"amount" integer
);

CREATE TABLE IF NOT EXISTS "users" (
	"id" serial PRIMARY KEY NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"name" varchar(100) NOT NULL,
	"picture" varchar(200),
	"weight_goal" integer,
	"height" integer,
	"birth_gender" genders,
	"calories_goal" integer,
	"email" varchar(100) NOT NULL,
	"password" varchar(100) NOT NULL
);

DO $$ BEGIN
 ALTER TABLE "household_invites" ADD CONSTRAINT "household_invites_user_users_id_fk" FOREIGN KEY ("user") REFERENCES "users"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;

DO $$ BEGIN
 ALTER TABLE "household_users" ADD CONSTRAINT "household_users_user_users_id_fk" FOREIGN KEY ("user") REFERENCES "users"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;

DO $$ BEGIN
 ALTER TABLE "household_users" ADD CONSTRAINT "household_users_household_households_id_fk" FOREIGN KEY ("household") REFERENCES "households"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;

DO $$ BEGIN
 ALTER TABLE "meals" ADD CONSTRAINT "meals_recipe_recipes_id_fk" FOREIGN KEY ("recipe") REFERENCES "recipes"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;

DO $$ BEGIN
 ALTER TABLE "recipe_ingredients" ADD CONSTRAINT "recipe_ingredients_recipe_recipes_id_fk" FOREIGN KEY ("recipe") REFERENCES "recipes"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;

DO $$ BEGIN
 ALTER TABLE "recipe_ingredients" ADD CONSTRAINT "recipe_ingredients_ingredient_ingredients_id_fk" FOREIGN KEY ("ingredient") REFERENCES "ingredients"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;

DO $$ BEGIN
 ALTER TABLE "recipes" ADD CONSTRAINT "recipes_household_households_id_fk" FOREIGN KEY ("household") REFERENCES "households"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;

DO $$ BEGIN
 ALTER TABLE "storage_items" ADD CONSTRAINT "storage_items_household_households_id_fk" FOREIGN KEY ("household") REFERENCES "households"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;

DO $$ BEGIN
 ALTER TABLE "storage_items" ADD CONSTRAINT "storage_items_ingredient_ingredients_id_fk" FOREIGN KEY ("ingredient") REFERENCES "ingredients"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
