import { pgTable, serial, timestamp } from 'drizzle-orm/pg-core'

export const defaultColumns = {
  id: serial('id').primaryKey(),
  createdAt: timestamp('created_at').defaultNow().notNull(),
  updatedAt: timestamp('updated_at').defaultNow().notNull(),
}