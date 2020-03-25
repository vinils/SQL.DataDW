USE [DataContext]
GO

/****** Object:  Table [dbo].[Data]    Script Date: 3/24/2020 6:24:20 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Data](
	[GroupId] [uniqueidentifier] NOT NULL,
	[CollectionDate] [datetime2](7) NOT NULL,
	[Discriminator] [nvarchar](max) NOT NULL,
	[DecimalValue] [decimal](18, 10) NULL,
	[StringValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_Data] PRIMARY KEY CLUSTERED 
(
	[GroupId] ASC,
	[CollectionDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

