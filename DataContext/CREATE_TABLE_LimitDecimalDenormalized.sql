USE [DataContext]
GO

/****** Object:  Table [dbo].[LimitDecimalDenormalized]    Script Date: 3/24/2020 6:50:06 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[LimitDecimalDenormalized](
	[GroupId] [uniqueidentifier] NOT NULL,
	[CollectionDate] [datetime2](7) NOT NULL,
	[Name] [nvarchar](max) NULL,
	[MinType] [int] NULL,
	[Min] [decimal](18, 2) NULL,
	[MaxType] [int] NULL,
	[Max] [decimal](18, 2) NULL,
	[Color] [int] NULL,
 CONSTRAINT [PK_LimitDecimalDenormalized] PRIMARY KEY CLUSTERED 
(
	[GroupId] ASC,
	[CollectionDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

