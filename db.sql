USE [master]
GO
CREATE DATABASE [аптека1]
 CONTAINMENT = NONE
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [аптека1] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [аптека1].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [аптека1] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [аптека1] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [аптека1] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [аптека1] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [аптека1] SET ARITHABORT OFF 
GO
ALTER DATABASE [аптека1] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [аптека1] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [аптека1] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [аптека1] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [аптека1] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [аптека1] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [аптека1] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [аптека1] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [аптека1] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [аптека1] SET  DISABLE_BROKER 
GO
ALTER DATABASE [аптека1] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [аптека1] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [аптека1] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [аптека1] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [аптека1] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [аптека1] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [аптека1] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [аптека1] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [аптека1] SET  MULTI_USER 
GO
ALTER DATABASE [аптека1] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [аптека1] SET DB_CHAINING OFF 
GO
ALTER DATABASE [аптека1] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [аптека1] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [аптека1] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [аптека1] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [аптека1] SET QUERY_STORE = ON
GO
ALTER DATABASE [аптека1] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [аптека1]
GO
/****** Object:  Table [dbo].[Позиции_продажи]    Script Date: 11.11.2026 10:58:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Позиции_продажи](
	[id_позиции] [int] IDENTITY(1,1) NOT NULL,
	[id_продажи] [int] NOT NULL,
	[id_серии] [int] NOT NULL,
	[количество] [int] NOT NULL,
	[цена_продажи] [decimal](12, 2) NULL,
	[сумма] [decimal](12, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_позиции] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Покупатели]    Script Date: 11.11.2026 10:58:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Покупатели](
	[id_покупателя] [int] IDENTITY(1,1) NOT NULL,
	[фио] [nvarchar](200) NULL,
	[телефон] [nvarchar](20) NULL,
	[дисконтная_карта] [nvarchar](50) NULL,
	[тип_покупателя] [nvarchar](50) NULL,
	[дата_регистрации] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_покупателя] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Поставки]    Script Date: 11.11.2026 10:58:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Поставки](
	[id_поставки] [int] IDENTITY(1,1) NOT NULL,
	[id_поставщика] [int] NOT NULL,
	[номер_накладной] [nvarchar](50) NOT NULL,
	[дата_поступления] [date] NOT NULL,
	[сумма] [decimal](12, 2) NULL,
	[статус] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_поставки] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Поставщики]    Script Date: 11.11.2026 10:58:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Поставщики](
	[id_поставщика] [int] IDENTITY(1,1) NOT NULL,
	[наименование] [nvarchar](200) NOT NULL,
	[инн] [nvarchar](20) NULL,
	[телефон] [nvarchar](20) NULL,
	[email] [nvarchar](100) NULL,
	[адрес] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_поставщика] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Продажи]    Script Date: 11.11.2026 10:58:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Продажи](
	[id_продажи] [int] IDENTITY(1,1) NOT NULL,
	[id_покупателя] [int] NULL,
	[id_сотрудника] [int] NOT NULL,
	[дата_время] [datetime] NULL,
	[сумма_итого] [decimal](12, 2) NULL,
	[сумма_скидки] [decimal](12, 2) NULL,
	[тип_оплаты] [nvarchar](50) NULL,
	[статус] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_продажи] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Серии_партии]    Script Date: 11.11.2026 10:58:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Серии_партии](
	[id_серии] [int] IDENTITY(1,1) NOT NULL,
	[id_товара] [int] NOT NULL,
	[id_поставки] [int] NULL,
	[номер_серии] [nvarchar](50) NULL,
	[срок_годности] [date] NOT NULL,
	[цена_закупочная] [decimal](12, 2) NOT NULL,
	[цена_розничная] [decimal](12, 2) NOT NULL,
	[остаток_склад] [int] NULL,
	[остаток_зал] [int] NULL,
	[ячейка_хранения] [nvarchar](50) NULL,
	[в_наличии] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_серии] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Сотрудники]    Script Date: 11.11.2026 10:58:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Сотрудники](
	[id_сотрудника] [int] IDENTITY(1,1) NOT NULL,
	[фио] [nvarchar](200) NOT NULL,
	[должность] [nvarchar](100) NULL,
	[роль] [nvarchar](50) NULL,
	[логин] [nvarchar](50) NOT NULL,
	[пароль_hash] [nvarchar](255) NOT NULL,
	[телефон] [nvarchar](20) NULL,
	[фото] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_сотрудника] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Списания]    Script Date: 11.11.2026 10:58:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Списания](
	[id_списания] [int] IDENTITY(1,1) NOT NULL,
	[id_серии] [int] NOT NULL,
	[дата] [date] NULL,
	[причина] [nvarchar](255) NULL,
	[количество] [int] NOT NULL,
	[сумма] [decimal](12, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_списания] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Товары]    Script Date: 11.11.2026 10:58:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Товары](
	[id_товара] [int] IDENTITY(1,1) NOT NULL,
	[штрихкод] [nvarchar](50) NULL,
	[наименование] [nvarchar](255) NOT NULL,
	[мнн] [nvarchar](255) NULL,
	[производитель] [nvarchar](200) NULL,
	[форма_выпуска] [nvarchar](100) NULL,
	[дозировка] [nvarchar](50) NULL,
	[упаковка] [nvarchar](100) NULL,
	[категория] [nvarchar](100) NULL,
	[рецептурный] [bit] NULL,
	[активен] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_товара] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Позиции_продажи] ON 

INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2005, 2009, 3, 1, CAST(130.00 AS Decimal(12, 2)), CAST(130.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2006, 2009, 6, 1, CAST(169.00 AS Decimal(12, 2)), CAST(169.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2007, 2009, 18, 1, CAST(325.00 AS Decimal(12, 2)), CAST(325.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2008, 2009, 11, 1, CAST(234.00 AS Decimal(12, 2)), CAST(234.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2009, 2009, 13, 1, CAST(260.00 AS Decimal(12, 2)), CAST(260.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2010, 2010, 5, 1, CAST(156.00 AS Decimal(12, 2)), CAST(156.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2011, 2010, 18, 1, CAST(325.00 AS Decimal(12, 2)), CAST(325.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2012, 2010, 10, 1, CAST(221.00 AS Decimal(12, 2)), CAST(221.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2013, 2011, 12, 2, CAST(247.00 AS Decimal(12, 2)), CAST(494.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2014, 2011, 9, 1, CAST(208.00 AS Decimal(12, 2)), CAST(208.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2015, 2011, 6, 1, CAST(169.00 AS Decimal(12, 2)), CAST(169.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2016, 2011, 13, 1, CAST(260.00 AS Decimal(12, 2)), CAST(260.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2017, 2012, 2, 1, CAST(117.00 AS Decimal(12, 2)), CAST(117.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2018, 2012, 16, 5, CAST(299.00 AS Decimal(12, 2)), CAST(1495.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2019, 2012, 7, 2, CAST(182.00 AS Decimal(12, 2)), CAST(364.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2020, 2012, 19, 2, CAST(338.00 AS Decimal(12, 2)), CAST(676.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2021, 2012, 8, 1, CAST(195.00 AS Decimal(12, 2)), CAST(195.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2022, 2012, 17, 1, CAST(312.00 AS Decimal(12, 2)), CAST(312.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2023, 2012, 6, 1, CAST(169.00 AS Decimal(12, 2)), CAST(169.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2024, 2015, 14, 1, CAST(273.00 AS Decimal(12, 2)), CAST(273.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2025, 2015, 3, 1, CAST(130.00 AS Decimal(12, 2)), CAST(130.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2026, 2015, 17, 1, CAST(312.00 AS Decimal(12, 2)), CAST(312.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2027, 2015, 9, 1, CAST(208.00 AS Decimal(12, 2)), CAST(208.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2029, 2015, 12, 3, CAST(247.00 AS Decimal(12, 2)), CAST(741.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2030, 2016, 1003, 3, CAST(130.00 AS Decimal(12, 2)), CAST(390.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2033, 2019, 11, 1, CAST(234.00 AS Decimal(12, 2)), CAST(234.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2034, 2019, 14, 1, CAST(273.00 AS Decimal(12, 2)), CAST(273.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2035, 2019, 13, 1, CAST(260.00 AS Decimal(12, 2)), CAST(260.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2036, 2019, 17, 1, CAST(312.00 AS Decimal(12, 2)), CAST(312.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2037, 2019, 6, 1, CAST(169.00 AS Decimal(12, 2)), CAST(169.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2039, 2019, 15, 2, CAST(286.00 AS Decimal(12, 2)), CAST(572.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2041, 2020, 5, 1, CAST(156.00 AS Decimal(12, 2)), CAST(156.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2042, 2020, 18, 1, CAST(325.00 AS Decimal(12, 2)), CAST(325.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2043, 2020, 9, 1, CAST(208.00 AS Decimal(12, 2)), CAST(208.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2044, 2020, 10, 1, CAST(221.00 AS Decimal(12, 2)), CAST(221.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2045, 2020, 12, 1, CAST(247.00 AS Decimal(12, 2)), CAST(247.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2046, 2020, 19, 3, CAST(338.00 AS Decimal(12, 2)), CAST(1014.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2047, 2020, 2, 3, CAST(117.00 AS Decimal(12, 2)), CAST(351.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2048, 2021, 1003, 1, CAST(130.00 AS Decimal(12, 2)), CAST(130.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2049, 2021, 11, 1, CAST(234.00 AS Decimal(12, 2)), CAST(234.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2050, 2021, 12, 1, CAST(247.00 AS Decimal(12, 2)), CAST(247.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2051, 2021, 3, 1, CAST(130.00 AS Decimal(12, 2)), CAST(130.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2053, 2021, 20, 1, CAST(351.00 AS Decimal(12, 2)), CAST(351.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2054, 2021, 2, 5, CAST(117.00 AS Decimal(12, 2)), CAST(585.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2055, 2022, 11, 1, CAST(234.00 AS Decimal(12, 2)), CAST(234.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2056, 2022, 3, 2, CAST(130.00 AS Decimal(12, 2)), CAST(260.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2057, 2022, 14, 1, CAST(273.00 AS Decimal(12, 2)), CAST(273.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2059, 2023, 12, 1, CAST(247.00 AS Decimal(12, 2)), CAST(247.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2060, 2023, 11, 1, CAST(234.00 AS Decimal(12, 2)), CAST(234.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2061, 2023, 1003, 2, CAST(130.00 AS Decimal(12, 2)), CAST(260.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2062, 2023, 6, 1, CAST(169.00 AS Decimal(12, 2)), CAST(169.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2063, 2023, 17, 2, CAST(312.00 AS Decimal(12, 2)), CAST(624.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2064, 2023, 14, 1, CAST(273.00 AS Decimal(12, 2)), CAST(273.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2066, 2025, 11, 1, CAST(234.00 AS Decimal(12, 2)), CAST(234.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2067, 2025, 6, 1, CAST(169.00 AS Decimal(12, 2)), CAST(169.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2068, 2025, 17, 1, CAST(312.00 AS Decimal(12, 2)), CAST(312.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2069, 2025, 5, 3, CAST(156.00 AS Decimal(12, 2)), CAST(468.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2070, 2026, 8, 2, CAST(195.00 AS Decimal(12, 2)), CAST(390.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2071, 2026, 1, 1, CAST(104.00 AS Decimal(12, 2)), CAST(104.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2072, 2026, 10, 1, CAST(221.00 AS Decimal(12, 2)), CAST(221.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2073, 2027, 5, 2, CAST(156.00 AS Decimal(12, 2)), CAST(312.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2074, 2027, 3, 1, CAST(130.00 AS Decimal(12, 2)), CAST(130.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2075, 2028, 1, 1, CAST(104.00 AS Decimal(12, 2)), CAST(104.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2076, 2028, 3, 1, CAST(130.00 AS Decimal(12, 2)), CAST(130.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2077, 2028, 5, 1, CAST(156.00 AS Decimal(12, 2)), CAST(156.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2078, 2029, 3, 2, CAST(130.00 AS Decimal(12, 2)), CAST(260.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2079, 2029, 5, 6, CAST(156.00 AS Decimal(12, 2)), CAST(936.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2080, 2029, 14, 1, CAST(273.00 AS Decimal(12, 2)), CAST(273.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2081, 2029, 10, 1, CAST(221.00 AS Decimal(12, 2)), CAST(221.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2082, 2030, 1, 1, CAST(104.00 AS Decimal(12, 2)), CAST(104.00 AS Decimal(12, 2)))
INSERT [dbo].[Позиции_продажи] ([id_позиции], [id_продажи], [id_серии], [количество], [цена_продажи], [сумма]) VALUES (2083, 2030, 10, 1, CAST(221.00 AS Decimal(12, 2)), CAST(221.00 AS Decimal(12, 2)))
SET IDENTITY_INSERT [dbo].[Позиции_продажи] OFF
GO
SET IDENTITY_INSERT [dbo].[Покупатели] ON 

INSERT [dbo].[Покупатели] ([id_покупателя], [фио], [телефон], [дисконтная_карта], [тип_покупателя], [дата_регистрации]) VALUES (1, N'Покупатель 1 И.И.', N'+7-901-007-00-00', NULL, N'Розничный', CAST(N'2026-09-14' AS Date))
INSERT [dbo].[Покупатели] ([id_покупателя], [фио], [телефон], [дисконтная_карта], [тип_покупателя], [дата_регистрации]) VALUES (3, N'Покупатель 3 И.И.', N'+7-903-021-00-00', N'DC-003', N'Розничный', CAST(N'2026-09-12' AS Date))
INSERT [dbo].[Покупатели] ([id_покупателя], [фио], [телефон], [дисконтная_карта], [тип_покупателя], [дата_регистрации]) VALUES (6, N'Покупатель 6 И.И.', N'+7-906-042-00-00', N'DC-006', N'Розничный', CAST(N'2026-09-09' AS Date))
INSERT [dbo].[Покупатели] ([id_покупателя], [фио], [телефон], [дисконтная_карта], [тип_покупателя], [дата_регистрации]) VALUES (9, N'Покупатель 9 И.И.', N'+7-909-063-00-00', N'DC-009', N'Розничный', CAST(N'2026-09-06' AS Date))
INSERT [dbo].[Покупатели] ([id_покупателя], [фио], [телефон], [дисконтная_карта], [тип_покупателя], [дата_регистрации]) VALUES (12, N'Покупатель 12 И.И.', N'+7-912-084-00-00', N'DC-012', N'Розничный', CAST(N'2026-09-03' AS Date))
INSERT [dbo].[Покупатели] ([id_покупателя], [фио], [телефон], [дисконтная_карта], [тип_покупателя], [дата_регистрации]) VALUES (15, N'Покупатель 15 И.И.', N'+7-915-105-00-00', N'DC-015', N'Оптовый', CAST(N'2026-08-31' AS Date))
INSERT [dbo].[Покупатели] ([id_покупателя], [фио], [телефон], [дисконтная_карта], [тип_покупателя], [дата_регистрации]) VALUES (18, N'Покупатель 18 И.И.', N'+7-918-126-00-00', N'DC-018', N'Розничный', CAST(N'2026-08-28' AS Date))
SET IDENTITY_INSERT [dbo].[Покупатели] OFF
GO
SET IDENTITY_INSERT [dbo].[Поставки] ON 

INSERT [dbo].[Поставки] ([id_поставки], [id_поставщика], [номер_накладной], [дата_поступления], [сумма], [статус]) VALUES (1, 1, N'НН-2026-001', CAST(N'2026-07-22' AS Date), CAST(58700.00 AS Decimal(12, 2)), N'Принята')
INSERT [dbo].[Поставки] ([id_поставки], [id_поставщика], [номер_накладной], [дата_поступления], [сумма], [статус]) VALUES (2, 2, N'НН-2026-002', CAST(N'2026-07-27' AS Date), CAST(66250.00 AS Decimal(12, 2)), N'Принята')
INSERT [dbo].[Поставки] ([id_поставки], [id_поставщика], [номер_накладной], [дата_поступления], [сумма], [статус]) VALUES (3, 3, N'НН-2026-003', CAST(N'2026-08-01' AS Date), CAST(44200.00 AS Decimal(12, 2)), N'Принята')
INSERT [dbo].[Поставки] ([id_поставки], [id_поставщика], [номер_накладной], [дата_поступления], [сумма], [статус]) VALUES (4, 1, N'НН-2026-004', CAST(N'2026-08-06' AS Date), CAST(17050.00 AS Decimal(12, 2)), N'Принята')
INSERT [dbo].[Поставки] ([id_поставки], [id_поставщика], [номер_накладной], [дата_поступления], [сумма], [статус]) VALUES (5, 2, N'НН-2026-005', CAST(N'2026-08-11' AS Date), CAST(21800.00 AS Decimal(12, 2)), N'Принята')
INSERT [dbo].[Поставки] ([id_поставки], [id_поставщика], [номер_накладной], [дата_поступления], [сумма], [статус]) VALUES (6, 3, N'НН-2026-006', CAST(N'2026-08-16' AS Date), CAST(26950.00 AS Decimal(12, 2)), N'Принята')
INSERT [dbo].[Поставки] ([id_поставки], [id_поставщика], [номер_накладной], [дата_поступления], [сумма], [статус]) VALUES (7, 1, N'НН-2026-007', CAST(N'2026-08-21' AS Date), CAST(32500.00 AS Decimal(12, 2)), N'Принята')
INSERT [dbo].[Поставки] ([id_поставки], [id_поставщика], [номер_накладной], [дата_поступления], [сумма], [статус]) VALUES (8, 2, N'НН-2026-008', CAST(N'2026-08-26' AS Date), CAST(38450.00 AS Decimal(12, 2)), N'Принята')
INSERT [dbo].[Поставки] ([id_поставки], [id_поставщика], [номер_накладной], [дата_поступления], [сумма], [статус]) VALUES (9, 3, N'НН-2026-009', CAST(N'2026-08-31' AS Date), CAST(44800.00 AS Decimal(12, 2)), N'Принята')
INSERT [dbo].[Поставки] ([id_поставки], [id_поставщика], [номер_накладной], [дата_поступления], [сумма], [статус]) VALUES (10, 1, N'НН-2026-010', CAST(N'2026-09-05' AS Date), CAST(51550.00 AS Decimal(12, 2)), N'Принята')
INSERT [dbo].[Поставки] ([id_поставки], [id_поставщика], [номер_накладной], [дата_поступления], [сумма], [статус]) VALUES (1002, 3, N'HH-2026-008', CAST(N'2026-05-09' AS Date), CAST(14570.00 AS Decimal(12, 2)), N'принято')
INSERT [dbo].[Поставки] ([id_поставки], [id_поставщика], [номер_накладной], [дата_поступления], [сумма], [статус]) VALUES (1012, 2, N'HH-2026-011', CAST(N'2026-08-23' AS Date), CAST(50000.00 AS Decimal(12, 2)), N'принята')
INSERT [dbo].[Поставки] ([id_поставки], [id_поставщика], [номер_накладной], [дата_поступления], [сумма], [статус]) VALUES (1014, 2, N'HH-2026-019', CAST(N'2026-08-23' AS Date), CAST(5000.00 AS Decimal(12, 2)), N'принята')
INSERT [dbo].[Поставки] ([id_поставки], [id_поставщика], [номер_накладной], [дата_поступления], [сумма], [статус]) VALUES (1016, 2, N'HH-2026-001', CAST(N'2026-08-23' AS Date), CAST(5000.00 AS Decimal(12, 2)), N'принята')
INSERT [dbo].[Поставки] ([id_поставки], [id_поставщика], [номер_накладной], [дата_поступления], [сумма], [статус]) VALUES (1018, 2, N'HH-2026-055', CAST(N'2026-08-23' AS Date), CAST(5000.00 AS Decimal(12, 2)), N'принята')
INSERT [dbo].[Поставки] ([id_поставки], [id_поставщика], [номер_накладной], [дата_поступления], [сумма], [статус]) VALUES (1021, 1, N'HH-2026-067', CAST(N'2026-06-22' AS Date), CAST(10000.00 AS Decimal(12, 2)), N'принята')
SET IDENTITY_INSERT [dbo].[Поставки] OFF
GO
SET IDENTITY_INSERT [dbo].[Поставщики] ON 

INSERT [dbo].[Поставщики] ([id_поставщика], [наименование], [инн], [телефон], [email], [адрес]) VALUES (1, N'Фарм-Трейд', N'7701234567', N'+7-495-111-22-33', N'info@farm-trade.ru', N'г. Москва, ул. Ленина, 10')
INSERT [dbo].[Поставщики] ([id_поставщика], [наименование], [инн], [телефон], [email], [адрес]) VALUES (2, N'МедПоставка', N'7709876543', N'+7-495-444-55-66', N'sales@medpost.ru', N'г. Москва, пр. Мира, 25')
INSERT [dbo].[Поставщики] ([id_поставщика], [наименование], [инн], [телефон], [email], [адрес]) VALUES (3, N'Здоровье+', N'7705556677', N'+7-495-777-88-99', N'order@zdorovye.ru', N'г. Санкт-Петербург, Невский, 5')
SET IDENTITY_INSERT [dbo].[Поставщики] OFF
GO
SET IDENTITY_INSERT [dbo].[Продажи] ON 

INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (1, NULL, 2, CAST(N'2026-09-28T23:38:26.903' AS DateTime), CAST(1586.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), N'Карта', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (3, NULL, 2, CAST(N'2026-10-03T19:46:26.903' AS DateTime), CAST(2470.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), N'Наличные', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (6, NULL, 1, CAST(N'2026-10-15T04:28:26.903' AS DateTime), CAST(988.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), N'Наличные', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (9, NULL, 2, CAST(N'2026-10-05T09:56:26.903' AS DateTime), CAST(3250.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), N'Наличные', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (12, NULL, 1, CAST(N'2026-10-08T18:31:26.903' AS DateTime), CAST(1300.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), N'Наличные', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (15, NULL, 2, CAST(N'2026-10-18T14:03:26.903' AS DateTime), CAST(1430.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), N'Наличные', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (18, NULL, 1, CAST(N'2026-10-16T11:30:26.903' AS DateTime), CAST(572.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), N'Наличные', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (21, NULL, 2, CAST(N'2026-10-15T04:20:26.903' AS DateTime), CAST(2160.00 AS Decimal(12, 2)), CAST(50.00 AS Decimal(12, 2)), N'Наличные', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (23, NULL, 2, CAST(N'2026-10-12T02:55:26.903' AS DateTime), CAST(1508.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), N'QR-код', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (26, NULL, 1, CAST(N'2026-10-09T11:25:26.903' AS DateTime), CAST(494.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), N'QR-код', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (29, NULL, 2, CAST(N'2026-10-18T14:07:26.903' AS DateTime), CAST(1976.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), N'QR-код', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (32, NULL, 1, CAST(N'2026-09-26T12:17:26.903' AS DateTime), CAST(650.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), N'QR-код', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (35, NULL, 2, CAST(N'2026-09-22T16:08:26.903' AS DateTime), CAST(834.00 AS Decimal(12, 2)), CAST(50.00 AS Decimal(12, 2)), N'QR-код', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (38, NULL, 1, CAST(N'2026-09-21T20:11:26.903' AS DateTime), CAST(286.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), N'QR-код', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (41, NULL, 2, CAST(N'2026-10-02T05:50:26.903' AS DateTime), CAST(1352.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), N'QR-код', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (43, NULL, 2, CAST(N'2026-10-11T04:56:26.903' AS DateTime), CAST(1794.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), N'Карта', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (46, NULL, 1, CAST(N'2026-10-20T00:12:26.903' AS DateTime), CAST(1482.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), N'Карта', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (49, NULL, 2, CAST(N'2026-10-04T15:08:26.903' AS DateTime), CAST(2368.00 AS Decimal(12, 2)), CAST(50.00 AS Decimal(12, 2)), N'Карта', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (51, NULL, 2, CAST(N'2026-10-05T00:44:26.903' AS DateTime), CAST(0.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), N'Карта', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (53, NULL, 2, CAST(N'2026-09-29T18:22:26.903' AS DateTime), CAST(0.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), N'Наличные', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (56, NULL, 1, CAST(N'2026-10-14T19:08:26.903' AS DateTime), CAST(0.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), N'Наличные', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (59, NULL, 2, CAST(N'2026-10-17T06:27:26.903' AS DateTime), CAST(0.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), N'Наличные', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (62, NULL, 1, CAST(N'2026-10-13T23:57:26.903' AS DateTime), CAST(0.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), N'Наличные', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (65, NULL, 2, CAST(N'2026-10-09T15:40:26.903' AS DateTime), CAST(0.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), N'Наличные', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (68, NULL, 1, CAST(N'2026-10-06T19:50:26.903' AS DateTime), CAST(0.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), N'Наличные', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (71, NULL, 2, CAST(N'2026-09-25T23:49:26.903' AS DateTime), CAST(-50.00 AS Decimal(12, 2)), CAST(50.00 AS Decimal(12, 2)), N'Наличные', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (73, NULL, 2, CAST(N'2026-10-11T16:57:26.903' AS DateTime), CAST(0.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), N'QR-код', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (76, NULL, 1, CAST(N'2026-10-07T16:32:26.903' AS DateTime), CAST(0.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), N'QR-код', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (79, NULL, 2, CAST(N'2026-10-03T12:41:26.903' AS DateTime), CAST(0.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), N'QR-код', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (82, NULL, 1, CAST(N'2026-10-20T07:54:26.903' AS DateTime), CAST(0.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), N'QR-код', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (85, NULL, 2, CAST(N'2026-09-20T22:12:26.903' AS DateTime), CAST(-50.00 AS Decimal(12, 2)), CAST(50.00 AS Decimal(12, 2)), N'QR-код', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (88, NULL, 1, CAST(N'2026-10-17T21:13:26.903' AS DateTime), CAST(0.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), N'QR-код', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (91, NULL, 2, CAST(N'2026-10-18T08:02:26.903' AS DateTime), CAST(0.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), N'QR-код', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (93, NULL, 2, CAST(N'2026-09-27T13:25:26.903' AS DateTime), CAST(0.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), N'Карта', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (96, NULL, 1, CAST(N'2026-10-16T22:25:26.903' AS DateTime), CAST(0.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), N'Карта', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (99, NULL, 2, CAST(N'2026-10-09T14:55:26.903' AS DateTime), CAST(-50.00 AS Decimal(12, 2)), CAST(50.00 AS Decimal(12, 2)), N'Карта', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (101, NULL, 2, CAST(N'2026-09-21T15:55:26.903' AS DateTime), CAST(780.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), N'Наличные', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (1004, NULL, 1, CAST(N'2026-10-15T01:35:26.903' AS DateTime), CAST(4567.00 AS Decimal(12, 2)), CAST(34.00 AS Decimal(12, 2)), N'наличка', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (1005, NULL, 2, CAST(N'2026-10-02T05:22:26.903' AS DateTime), CAST(9999999.00 AS Decimal(12, 2)), CAST(101.00 AS Decimal(12, 2)), N'Карта', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (1006, NULL, 1, CAST(N'2026-10-04T07:55:26.903' AS DateTime), CAST(6543.00 AS Decimal(12, 2)), CAST(87.00 AS Decimal(12, 2)), N'jhgf', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (1007, NULL, 2, CAST(N'2026-09-25T17:45:26.903' AS DateTime), CAST(1131.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), N'Наличные', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (1008, NULL, 1, CAST(N'2026-09-26T14:09:26.903' AS DateTime), CAST(1053.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), N'Наличные', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (1009, NULL, 2, CAST(N'2026-10-18T06:19:26.903' AS DateTime), CAST(299.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), N'Наличные', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (1010, NULL, 1, CAST(N'2026-10-20T18:03:26.903' AS DateTime), CAST(377.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), N'Наличные', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (2007, NULL, 2, CAST(N'2026-09-22T18:27:26.903' AS DateTime), CAST(585.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), N'Наличные', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (2008, NULL, 1, CAST(N'2026-09-29T10:49:26.903' AS DateTime), CAST(6577.00 AS Decimal(12, 2)), CAST(5.00 AS Decimal(12, 2)), N'7', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (2009, NULL, 2, CAST(N'2026-10-21T19:14:04.557' AS DateTime), CAST(1118.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), N'Наличные', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (2010, NULL, 2, CAST(N'2026-10-21T19:19:54.670' AS DateTime), CAST(702.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), N'Наличные', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (2011, NULL, 2, CAST(N'2026-10-21T19:19:59.990' AS DateTime), CAST(1131.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), N'Наличные', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (2012, NULL, 2, CAST(N'2026-10-21T19:20:13.207' AS DateTime), CAST(3328.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), N'Наличные', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (2014, 12, 1, CAST(N'2026-10-21T19:43:03.837' AS DateTime), CAST(5000.00 AS Decimal(12, 2)), CAST(2346.00 AS Decimal(12, 2)), N'карта', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (2015, NULL, 2, CAST(N'2026-10-23T12:43:47.970' AS DateTime), CAST(1807.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), N'Наличные', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (2016, NULL, 2, CAST(N'2026-10-23T14:02:59.430' AS DateTime), CAST(390.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), N'Наличные', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (2017, NULL, 2, CAST(N'2026-10-23T14:20:56.750' AS DateTime), CAST(130.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), N'Наличные', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (2018, NULL, 2, CAST(N'2026-10-23T15:30:15.033' AS DateTime), CAST(1281.80 AS Decimal(12, 2)), CAST(226.20 AS Decimal(12, 2)), N'Наличные', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (2019, NULL, 2, CAST(N'2026-10-23T15:32:09.167' AS DateTime), CAST(2000.70 AS Decimal(12, 2)), CAST(105.30 AS Decimal(12, 2)), N'Наличные', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (2020, NULL, 2, CAST(N'2026-10-23T15:39:35.243' AS DateTime), CAST(2531.75 AS Decimal(12, 2)), CAST(133.25 AS Decimal(12, 2)), N'QR-код', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (2021, NULL, 2, CAST(N'2026-10-23T15:46:07.737' AS DateTime), CAST(1567.80 AS Decimal(12, 2)), CAST(174.20 AS Decimal(12, 2)), N'Карта', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (2022, NULL, 2, CAST(N'2026-10-23T16:50:04.557' AS DateTime), CAST(864.50 AS Decimal(12, 2)), CAST(45.50 AS Decimal(12, 2)), N'Карта', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (2023, NULL, 2, CAST(N'2026-10-23T17:21:12.487' AS DateTime), CAST(1535.95 AS Decimal(12, 2)), CAST(271.05 AS Decimal(12, 2)), N'QR-код', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (2024, NULL, 2, CAST(N'2026-10-23T17:26:01.060' AS DateTime), CAST(195.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), N'Наличные', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (2025, NULL, 2, CAST(N'2026-10-23T18:07:44.610' AS DateTime), CAST(1123.85 AS Decimal(12, 2)), CAST(59.15 AS Decimal(12, 2)), N'Карта', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (2026, NULL, 2, CAST(N'2026-10-23T22:24:10.967' AS DateTime), CAST(715.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), N'Наличные', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (2027, NULL, 2, CAST(N'2026-10-23T22:26:40.850' AS DateTime), CAST(375.70 AS Decimal(12, 2)), CAST(66.30 AS Decimal(12, 2)), N'QR-код', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (2028, NULL, 2, CAST(N'2026-10-24T15:31:43.760' AS DateTime), CAST(331.50 AS Decimal(12, 2)), CAST(58.50 AS Decimal(12, 2)), N'QR-код', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (2029, NULL, 2, CAST(N'2026-10-24T19:11:42.077' AS DateTime), CAST(1605.50 AS Decimal(12, 2)), CAST(84.50 AS Decimal(12, 2)), N'Карта', N'Закрыт')
INSERT [dbo].[Продажи] ([id_продажи], [id_покупателя], [id_сотрудника], [дата_время], [сумма_итого], [сумма_скидки], [тип_оплаты], [статус]) VALUES (2030, NULL, 2, CAST(N'2026-11-10T09:50:28.833' AS DateTime), CAST(276.25 AS Decimal(12, 2)), CAST(48.75 AS Decimal(12, 2)), N'Карта', N'Закрыт')
SET IDENTITY_INSERT [dbo].[Продажи] OFF
GO
SET IDENTITY_INSERT [dbo].[Серии_партии] ON 

INSERT [dbo].[Серии_партии] ([id_серии], [id_товара], [id_поставки], [номер_серии], [срок_годности], [цена_закупочная], [цена_розничная], [остаток_склад], [остаток_зал], [ячейка_хранения], [в_наличии]) VALUES (1, 1, 3, N'СЕР-0001-1', CAST(N'2027-09-10' AS Date), CAST(80.00 AS Decimal(12, 2)), CAST(104.00 AS Decimal(12, 2)), 68, 9, N'Я-3', 1)
INSERT [dbo].[Серии_партии] ([id_серии], [id_товара], [id_поставки], [номер_серии], [срок_годности], [цена_закупочная], [цена_розничная], [остаток_склад], [остаток_зал], [ячейка_хранения], [в_наличии]) VALUES (2, 1, 4, N'СЕР-0001-2', CAST(N'2027-07-12' AS Date), CAST(90.00 AS Decimal(12, 2)), CAST(117.00 AS Decimal(12, 2)), 119, 119, N'Я-4', 1)
INSERT [dbo].[Серии_партии] ([id_серии], [id_товара], [id_поставки], [номер_серии], [срок_годности], [цена_закупочная], [цена_розничная], [остаток_склад], [остаток_зал], [ячейка_хранения], [в_наличии]) VALUES (3, 2, 4, N'СЕР-0002-1', CAST(N'2027-09-30' AS Date), CAST(100.00 AS Decimal(12, 2)), CAST(130.00 AS Decimal(12, 2)), 30, 30, N'Я-4', 1)
INSERT [dbo].[Серии_партии] ([id_серии], [id_товара], [id_поставки], [номер_серии], [срок_годности], [цена_закупочная], [цена_розничная], [остаток_склад], [остаток_зал], [ячейка_хранения], [в_наличии]) VALUES (5, 3, 5, N'СЕР-0003-1', CAST(N'2027-10-20' AS Date), CAST(120.00 AS Decimal(12, 2)), CAST(156.00 AS Decimal(12, 2)), 138, 138, N'Я-5', 1)
INSERT [dbo].[Серии_партии] ([id_серии], [id_товара], [id_поставки], [номер_серии], [срок_годности], [цена_закупочная], [цена_розничная], [остаток_склад], [остаток_зал], [ячейка_хранения], [в_наличии]) VALUES (6, 3, 6, N'СЕР-0003-2', CAST(N'2027-08-21' AS Date), CAST(130.00 AS Decimal(12, 2)), CAST(169.00 AS Decimal(12, 2)), 89, 10, N'Я-1', 1)
INSERT [dbo].[Серии_партии] ([id_серии], [id_товара], [id_поставки], [номер_серии], [срок_годности], [цена_закупочная], [цена_розничная], [остаток_склад], [остаток_зал], [ячейка_хранения], [в_наличии]) VALUES (7, 4, 6, N'СЕР-0004-1', CAST(N'2027-11-09' AS Date), CAST(140.00 AS Decimal(12, 2)), CAST(182.00 AS Decimal(12, 2)), 77, 14, N'Я-1', 1)
INSERT [dbo].[Серии_партии] ([id_серии], [id_товара], [id_поставки], [номер_серии], [срок_годности], [цена_закупочная], [цена_розничная], [остаток_склад], [остаток_зал], [ячейка_хранения], [в_наличии]) VALUES (8, 4, 7, N'СЕР-0004-2', CAST(N'2027-09-10' AS Date), CAST(150.00 AS Decimal(12, 2)), CAST(195.00 AS Decimal(12, 2)), 92, 14, N'Я-2', 1)
INSERT [dbo].[Серии_партии] ([id_серии], [id_товара], [id_поставки], [номер_серии], [срок_годности], [цена_закупочная], [цена_розничная], [остаток_склад], [остаток_зал], [ячейка_хранения], [в_наличии]) VALUES (9, 5, 7, N'СЕР-0005-1', CAST(N'2027-11-29' AS Date), CAST(160.00 AS Decimal(12, 2)), CAST(208.00 AS Decimal(12, 2)), 80, 15, N'Я-2', 1)
INSERT [dbo].[Серии_партии] ([id_серии], [id_товара], [id_поставки], [номер_серии], [срок_годности], [цена_закупочная], [цена_розничная], [остаток_склад], [остаток_зал], [ячейка_хранения], [в_наличии]) VALUES (10, 5, 8, N'СЕР-0005-2', CAST(N'2027-09-30' AS Date), CAST(170.00 AS Decimal(12, 2)), CAST(221.00 AS Decimal(12, 2)), 95, 13, N'Я-3', 1)
INSERT [dbo].[Серии_партии] ([id_серии], [id_товара], [id_поставки], [номер_серии], [срок_годности], [цена_закупочная], [цена_розничная], [остаток_склад], [остаток_зал], [ячейка_хранения], [в_наличии]) VALUES (11, 6, 8, N'СЕР-0006-1', CAST(N'2027-12-19' AS Date), CAST(180.00 AS Decimal(12, 2)), CAST(234.00 AS Decimal(12, 2)), 83, 15, N'Я-3', 1)
INSERT [dbo].[Серии_партии] ([id_серии], [id_товара], [id_поставки], [номер_серии], [срок_годности], [цена_закупочная], [цена_розничная], [остаток_склад], [остаток_зал], [ячейка_хранения], [в_наличии]) VALUES (12, 6, 9, N'СЕР-0006-2', CAST(N'2027-10-20' AS Date), CAST(190.00 AS Decimal(12, 2)), CAST(247.00 AS Decimal(12, 2)), 99, 12, N'Я-4', 1)
INSERT [dbo].[Серии_партии] ([id_серии], [id_товара], [id_поставки], [номер_серии], [срок_годности], [цена_закупочная], [цена_розничная], [остаток_склад], [остаток_зал], [ячейка_хранения], [в_наличии]) VALUES (13, 7, 9, N'СЕР-0007-1', CAST(N'2028-01-08' AS Date), CAST(200.00 AS Decimal(12, 2)), CAST(260.00 AS Decimal(12, 2)), 86, 21, N'Я-4', 1)
INSERT [dbo].[Серии_партии] ([id_серии], [id_товара], [id_поставки], [номер_серии], [срок_годности], [цена_закупочная], [цена_розничная], [остаток_склад], [остаток_зал], [ячейка_хранения], [в_наличии]) VALUES (14, 7, 10, N'СЕР-0007-2', CAST(N'2027-11-09' AS Date), CAST(210.00 AS Decimal(12, 2)), CAST(273.00 AS Decimal(12, 2)), 101, 18, N'Я-5', 1)
INSERT [dbo].[Серии_партии] ([id_серии], [id_товара], [id_поставки], [номер_серии], [срок_годности], [цена_закупочная], [цена_розничная], [остаток_склад], [остаток_зал], [ячейка_хранения], [в_наличии]) VALUES (15, 8, 10, N'СЕР-0008-1', CAST(N'2028-01-28' AS Date), CAST(220.00 AS Decimal(12, 2)), CAST(286.00 AS Decimal(12, 2)), 89, 24, N'Я-5', 1)
INSERT [dbo].[Серии_партии] ([id_серии], [id_товара], [id_поставки], [номер_серии], [срок_годности], [цена_закупочная], [цена_розничная], [остаток_склад], [остаток_зал], [ячейка_хранения], [в_наличии]) VALUES (16, 8, 1, N'СЕР-0008-2', CAST(N'2027-11-29' AS Date), CAST(230.00 AS Decimal(12, 2)), CAST(299.00 AS Decimal(12, 2)), 104, 20, N'Я-1', 1)
INSERT [dbo].[Серии_партии] ([id_серии], [id_товара], [id_поставки], [номер_серии], [срок_годности], [цена_закупочная], [цена_розничная], [остаток_склад], [остаток_зал], [ячейка_хранения], [в_наличии]) VALUES (17, 9, 1, N'СЕР-0009-1', CAST(N'2028-02-17' AS Date), CAST(240.00 AS Decimal(12, 2)), CAST(312.00 AS Decimal(12, 2)), 92, 21, N'Я-1', 1)
INSERT [dbo].[Серии_партии] ([id_серии], [id_товара], [id_поставки], [номер_серии], [срок_годности], [цена_закупочная], [цена_розничная], [остаток_склад], [остаток_зал], [ячейка_хранения], [в_наличии]) VALUES (18, 9, 2, N'СЕР-0009-2', CAST(N'2027-12-19' AS Date), CAST(250.00 AS Decimal(12, 2)), CAST(325.00 AS Decimal(12, 2)), 107, 25, N'Я-2', 1)
INSERT [dbo].[Серии_партии] ([id_серии], [id_товара], [id_поставки], [номер_серии], [срок_годности], [цена_закупочная], [цена_розничная], [остаток_склад], [остаток_зал], [ячейка_хранения], [в_наличии]) VALUES (19, 10, 2, N'СЕР-0010-1', CAST(N'2028-03-08' AS Date), CAST(260.00 AS Decimal(12, 2)), CAST(338.00 AS Decimal(12, 2)), 95, 24, N'Я-2', 1)
INSERT [dbo].[Серии_партии] ([id_серии], [id_товара], [id_поставки], [номер_серии], [срок_годности], [цена_закупочная], [цена_розничная], [остаток_склад], [остаток_зал], [ячейка_хранения], [в_наличии]) VALUES (20, 10, 3, N'СЕР-0010-2', CAST(N'2028-01-08' AS Date), CAST(270.00 AS Decimal(12, 2)), CAST(351.00 AS Decimal(12, 2)), 110, 29, N'Я-3', 1)
INSERT [dbo].[Серии_партии] ([id_серии], [id_товара], [id_поставки], [номер_серии], [срок_годности], [цена_закупочная], [цена_розничная], [остаток_склад], [остаток_зал], [ячейка_хранения], [в_наличии]) VALUES (1003, 7, 1021, N'СЕР-75160039', CAST(N'2027-10-23' AS Date), CAST(100.00 AS Decimal(12, 2)), CAST(130.00 AS Decimal(12, 2)), 60, 0, NULL, 1)
SET IDENTITY_INSERT [dbo].[Серии_партии] OFF
GO
SET IDENTITY_INSERT [dbo].[Сотрудники] ON 

INSERT [dbo].[Сотрудники] ([id_сотрудника], [фио], [должность], [роль], [логин], [пароль_hash], [телефон], [фото]) VALUES (1, N'Иванова Анна Александровна', N'Заведующая аптекой', N'Администратор', N'admin', N'admin123', N'+7-900-100-10-10', N'')
INSERT [dbo].[Сотрудники] ([id_сотрудника], [фио], [должность], [роль], [логин], [пароль_hash], [телефон], [фото]) VALUES (2, N'Петров Иван Сергеевич', N'Фармацевт-кассир', N'Фармацевт-кассир', N'farm1', N'farm123', N'+7-900-200-20-20', N'')
SET IDENTITY_INSERT [dbo].[Сотрудники] OFF
GO
SET IDENTITY_INSERT [dbo].[Товары] ON 

INSERT [dbo].[Товары] ([id_товара], [штрихкод], [наименование], [мнн], [производитель], [форма_выпуска], [дозировка], [упаковка], [категория], [рецептурный], [активен]) VALUES (1, N'4601111111111', N'Парацетамол', N'Парацетамол', N'Фармстандарт', N'Таблетки', N'500 мг', N'№20', N'Безрецептурное', 0, 1)
INSERT [dbo].[Товары] ([id_товара], [штрихкод], [наименование], [мнн], [производитель], [форма_выпуска], [дозировка], [упаковка], [категория], [рецептурный], [активен]) VALUES (2, N'4601111111112', N'Анальгин', N'Метамизол натрия', N'Фармстандарт', N'Таблетки', N'500 мг', N'№10', N'Безрецептурное', 0, 1)
INSERT [dbo].[Товары] ([id_товара], [штрихкод], [наименование], [мнн], [производитель], [форма_выпуска], [дозировка], [упаковка], [категория], [рецептурный], [активен]) VALUES (3, N'4601111111113', N'Аспирин Кардио', N'Ацетилсалициловая', N'Bayer', N'Таблетки', N'100 мг', N'№28', N'Безрецептурное', 0, 1)
INSERT [dbo].[Товары] ([id_товара], [штрихкод], [наименование], [мнн], [производитель], [форма_выпуска], [дозировка], [упаковка], [категория], [рецептурный], [активен]) VALUES (4, N'4601111111114', N'Но-Шпа', N'Дротаверин', N'Sanofi', N'Таблетки', N'40 мг', N'№24', N'Безрецептурное', 0, 1)
INSERT [dbo].[Товары] ([id_товара], [штрихкод], [наименование], [мнн], [производитель], [форма_выпуска], [дозировка], [упаковка], [категория], [рецептурный], [активен]) VALUES (5, N'4601111111115', N'Витамин C', N'Аскорбиновая к-та', N'Фармстандарт', N'Драже', N'50 мг', N'№50', N'БАД', 0, 1)
INSERT [dbo].[Товары] ([id_товара], [штрихкод], [наименование], [мнн], [производитель], [форма_выпуска], [дозировка], [упаковка], [категория], [рецептурный], [активен]) VALUES (6, N'4601111111116', N'Амоксициллин', N'Амоксициллин', N'Синтез', N'Капсулы', N'500 мг', N'№16', N'Рецептурное', 1, 1)
INSERT [dbo].[Товары] ([id_товара], [штрихкод], [наименование], [мнн], [производитель], [форма_выпуска], [дозировка], [упаковка], [категория], [рецептурный], [активен]) VALUES (7, N'4601111111117', N'Азитромицин', N'Азитромицин', N'Синтез', N'Таблетки', N'500 мг', N'№33', N'Рецептурное', 1, 1)
INSERT [dbo].[Товары] ([id_товара], [штрихкод], [наименование], [мнн], [производитель], [форма_выпуска], [дозировка], [упаковка], [категория], [рецептурный], [активен]) VALUES (8, N'4601111111118', N'Ибупрофен', N'Ибупрофен', N'Фармстандарт', N'Таблетки', N'400 мг', N'№20', N'Рецептурное', 1, 1)
INSERT [dbo].[Товары] ([id_товара], [штрихкод], [наименование], [мнн], [производитель], [форма_выпуска], [дозировка], [упаковка], [категория], [рецептурный], [активен]) VALUES (9, N'4601111111119', N'Бинт стерильный', N'бинт', N'Медтехника', N'Изделие', N'5м', N'№9', N'Мед. изделие', 0, 1)
INSERT [dbo].[Товары] ([id_товара], [штрихкод], [наименование], [мнн], [производитель], [форма_выпуска], [дозировка], [упаковка], [категория], [рецептурный], [активен]) VALUES (10, N'4601111111120', N'Пластырь', N'пластырь', N'Медтехника', N'Изделие', N'20мг', N'№20', N'Мед. изделие', 0, 1)
SET IDENTITY_INSERT [dbo].[Товары] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Покупате__396274BD054556A8]    Script Date: 11.11.2026 10:58:54 ******/
ALTER TABLE [dbo].[Покупатели] ADD UNIQUE NONCLUSTERED 
(
	[дисконтная_карта] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Поставки__7A4311E187D710A7]    Script Date: 11.11.2026 10:58:54 ******/
ALTER TABLE [dbo].[Поставки] ADD UNIQUE NONCLUSTERED 
(
	[номер_накладной] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Поставщи__C92DFE5FCD18C95F]    Script Date: 11.11.2026 10:58:54 ******/
ALTER TABLE [dbo].[Поставщики] ADD UNIQUE NONCLUSTERED 
(
	[инн] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Сотрудни__5EB64DCC6C81354C]    Script Date: 11.11.2026 10:58:54 ******/
ALTER TABLE [dbo].[Сотрудники] ADD UNIQUE NONCLUSTERED 
(
	[логин] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Товары__64456D0402F4BF1B]    Script Date: 11.11.2026 10:58:54 ******/
ALTER TABLE [dbo].[Товары] ADD UNIQUE NONCLUSTERED 
(
	[штрихкод] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Покупатели] ADD  DEFAULT (N'Розничный') FOR [тип_покупателя]
GO
ALTER TABLE [dbo].[Покупатели] ADD  DEFAULT (CONVERT([date],getdate())) FOR [дата_регистрации]
GO
ALTER TABLE [dbo].[Поставки] ADD  DEFAULT (N'Принята') FOR [статус]
GO
ALTER TABLE [dbo].[Продажи] ADD  DEFAULT (getdate()) FOR [дата_время]
GO
ALTER TABLE [dbo].[Продажи] ADD  DEFAULT ((0)) FOR [сумма_скидки]
GO
ALTER TABLE [dbo].[Продажи] ADD  DEFAULT (N'Закрыт') FOR [статус]
GO
ALTER TABLE [dbo].[Серии_партии] ADD  DEFAULT ((0)) FOR [остаток_склад]
GO
ALTER TABLE [dbo].[Серии_партии] ADD  DEFAULT ((0)) FOR [остаток_зал]
GO
ALTER TABLE [dbo].[Серии_партии] ADD  DEFAULT ((1)) FOR [в_наличии]
GO
ALTER TABLE [dbo].[Списания] ADD  DEFAULT (CONVERT([date],getdate())) FOR [дата]
GO
ALTER TABLE [dbo].[Товары] ADD  DEFAULT ((0)) FOR [рецептурный]
GO
ALTER TABLE [dbo].[Товары] ADD  DEFAULT ((1)) FOR [активен]
GO
ALTER TABLE [dbo].[Позиции_продажи]  WITH CHECK ADD FOREIGN KEY([id_продажи])
REFERENCES [dbo].[Продажи] ([id_продажи])
GO
ALTER TABLE [dbo].[Позиции_продажи]  WITH CHECK ADD FOREIGN KEY([id_серии])
REFERENCES [dbo].[Серии_партии] ([id_серии])
GO
ALTER TABLE [dbo].[Поставки]  WITH CHECK ADD FOREIGN KEY([id_поставщика])
REFERENCES [dbo].[Поставщики] ([id_поставщика])
GO
ALTER TABLE [dbo].[Продажи]  WITH CHECK ADD FOREIGN KEY([id_покупателя])
REFERENCES [dbo].[Покупатели] ([id_покупателя])
GO
ALTER TABLE [dbo].[Продажи]  WITH CHECK ADD FOREIGN KEY([id_сотрудника])
REFERENCES [dbo].[Сотрудники] ([id_сотрудника])
GO
ALTER TABLE [dbo].[Серии_партии]  WITH CHECK ADD FOREIGN KEY([id_поставки])
REFERENCES [dbo].[Поставки] ([id_поставки])
GO
ALTER TABLE [dbo].[Серии_партии]  WITH CHECK ADD FOREIGN KEY([id_товара])
REFERENCES [dbo].[Товары] ([id_товара])
GO
ALTER TABLE [dbo].[Списания]  WITH CHECK ADD FOREIGN KEY([id_серии])
REFERENCES [dbo].[Серии_партии] ([id_серии])
GO
USE [master]
GO
ALTER DATABASE [аптека1] SET  READ_WRITE 
GO
